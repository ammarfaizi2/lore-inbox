Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262592AbVAPTmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbVAPTmm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 14:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbVAPTmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 14:42:42 -0500
Received: from opersys.com ([64.40.108.71]:17938 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262592AbVAPTm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 14:42:29 -0500
Message-ID: <41EAC560.30202@opersys.com>
Date: Sun, 16 Jan 2005 14:49:52 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: tglx@linutronix.de, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Robert Wisniewski <bob@watson.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org> <1105740276.8604.83.camel@tglx.tec.linutronix.de> <41E85123.7080005@opersys.com> <20050116162127.GC26144@infradead.org>
In-Reply-To: <20050116162127.GC26144@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Hellwig wrote:
> the lockless mode is really just loops around cmpxchg.  It's spinlocks
> reinvented poorly.

I beg to differ. You have to use different spinlocks depending on
where you are:
- serving user-space
- bh-derivatives
- irq

lockless is the same primitive regardless of your current state,
it's not the same as spinlocks.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
