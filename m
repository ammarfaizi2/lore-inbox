Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272508AbTGaPM2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272509AbTGaPLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:11:19 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:33152 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S272508AbTGaPKX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:10:23 -0400
Date: Thu, 31 Jul 2003 16:10:20 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: TSCs are a no-no on i386
Message-ID: <20030731151020.GF6410@mail.jlokier.co.uk>
References: <20030730135623.GA1873@lug-owl.de> <20030730181006.GB21734@fs.tum.de> <20030730183033.GA970@matchmail.com> <20030730184529.GE21734@fs.tum.de> <20030730202822.GG1873@lug-owl.de> <20030730215032.GA18892@vana.vc.cvut.cz> <1059606394.10505.24.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059606394.10505.24.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2003-07-30 at 22:50, Petr Vandrovec wrote:
> > There is no such instruction. Skip LOCK prefix and decode again,
> > you'll get either cmpxchg or xadd (or cmpxchg8b, but then it does
> > not work on i486 too).
> 
> And if the byte you are looking at was patched by another thread you've
> blown it. Your emulation can only be so good 8) People do stuff like
> patching instructions under software decode as a robustness check - its
> normally pretty amusing

On a uniprocessor 386, this is not a problem.  Just disable preemption
in the kernel decoder.

Of course if you do it in userspace using SIGILL, then it is broken :)

-- Jamie

