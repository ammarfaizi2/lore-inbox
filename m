Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbVLSXiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVLSXiF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 18:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVLSXiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 18:38:05 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:17055 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750705AbVLSXiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 18:38:03 -0500
Date: Mon, 19 Dec 2005 23:37:54 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [patch 00/15] Generic Mutex Subsystem
Message-ID: <20051219233754.GA20058@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	Andi Kleen <ak@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjanv@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@ftp.linux.org.uk>,
	Oleg Nesterov <oleg@tv-sign.ru>, Benjamin LaHaise <bcrl@kvack.org>
References: <20051219013415.GA27658@elte.hu> <20051219042248.GG23384@wotan.suse.de> <Pine.LNX.4.64.0512182214400.4827@g5.osdl.org> <20051219155010.GA7790@elte.hu> <Pine.LNX.4.64.0512191053400.4827@g5.osdl.org> <20051219195553.GA14155@elte.hu> <Pine.LNX.4.64.0512191203120.4827@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512191203120.4827@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2005 at 12:12:26PM -0800, Linus Torvalds wrote:
> And don't get me wrong: if it's easier to just ignore the performance bug, 
> and introduce a new "struct mutex" that just doesn't have it, I'm all for 
> it. However, if so, I do NOT want to do the unnecessary renaming. "struct 
> semaphore" should stay as "struct semaphore", and we should not affect old 
> code in the _least_.
> 
> Then code can switch to "struct mutex" if people want to. And if one 
> reason for it ends up being that the code avoids a performance bug in the 
> process, all the better ;)
> 
> IOW, I really think this should be a series of small patches that don't 
> touch old users of "struct semaphore" at all. None of this "semaphore" to 
> "arch_semaphore" stuff, and the new "struct mutex" would not re-use _any_ 
> of the names that the old "struct semaphore" uses.

That's exactly what Ingo's series does if you ignore the two odd patches ;-)
