Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262537AbVAPQWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262537AbVAPQWt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 11:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVAPQVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 11:21:52 -0500
Received: from [213.146.154.40] ([213.146.154.40]:14281 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262537AbVAPQV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 11:21:29 -0500
Date: Sun, 16 Jan 2005 16:21:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Karim Yaghmour <karim@opersys.com>
Cc: tglx@linutronix.de, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc1-mm1
Message-ID: <20050116162127.GC26144@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Karim Yaghmour <karim@opersys.com>, tglx@linutronix.de,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20050114002352.5a038710.akpm@osdl.org> <1105740276.8604.83.camel@tglx.tec.linutronix.de> <41E85123.7080005@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E85123.7080005@opersys.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 06:09:23PM -0500, Karim Yaghmour wrote:
> relayfs implements two schemes: lockless and locking. The later uses
> standard linear locking mechanisms. If you need stringent constant
> time, you know what to do.

the lockless mode is really just loops around cmpxchg.  It's spinlocks
reinvented poorly.

