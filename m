Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262887AbVAQVb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbVAQVb3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 16:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262891AbVAQVb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 16:31:29 -0500
Received: from opersys.com ([64.40.108.71]:10761 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262887AbVAQVbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 16:31:07 -0500
Message-ID: <41EC3053.3020508@opersys.com>
Date: Mon, 17 Jan 2005 16:38:27 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Robert Wisniewski <bob@watson.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org> <1105740276.8604.83.camel@tglx.tec.linutronix.de> <41E85123.7080005@opersys.com> <20050116162127.GC26144@infradead.org> <41EAC560.30202@opersys.com> <16874.50688.68959.36156@kix.watson.ibm.com> <20050116123212.1b22495b.akpm@osdl.org> <16874.54187.919814.272833@kix.watson.ibm.com> <1105911624.8734.55.camel@laptopd505.fenrus.org> <16875.56543.264481.586616@kix.watson.ibm.com> <20050117161335.GA9404@infradead.org>
In-Reply-To: <20050117161335.GA9404@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Chistoph,

Christoph Hellwig wrote:
> The thing I'm unhappy with is what the code does currently.  I haven't
> looked at the code enough nor through about the problem enough to tell
> you what's the right thing to do.  Knowing that will involve review of
> the architecture and serious benchmarking on a few plattforms.

Like I was saying elswhere, we are likely going to drop the lockless
code for now (i.e. the code that does the cmpxchg). Instead we will
depend on normal cli/sti abstractions.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
