Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVCITli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVCITli (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 14:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVCITl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 14:41:28 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:60074 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261254AbVCITkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 14:40:39 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: Andi Kleen <ak@muc.de>
Subject: Re: [patch 1/1] x86-64: forgot asmlinkage on sys_mmap
Date: Wed, 9 Mar 2005 20:40:22 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050305190005.0943C4B47@zion> <200503091924.00518.blaisorblade@yahoo.it> <20050309193454.GB17918@muc.de>
In-Reply-To: <20050309193454.GB17918@muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503092040.22780.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 March 2005 20:34, Andi Kleen wrote:
> On Wed, Mar 09, 2005 at 07:24:00PM +0100, Blaisorblade wrote:
> > On Wednesday 09 March 2005 18:24, Andi Kleen wrote:
> > > blaisorblade@yahoo.it writes:
> > > > CC: Andi Kleen <ak@suse.de>
> > > >
> > > > I think it should be there, please check better.
> > >
> > > It doesn't matter. asmlinkage is a nop on x86-64.
> >
> > Yes, otherwise nothing would work on x86-64 with mmap broken, but for
> > cleanness and for the case this change it should be there (otherwise why
> > asmlinkage is used in the rest of the file).
>
> Only because it was cut'n'pasted from i386 originally.
>
> > And for i386 asmlinkage acquired significance only recently.
>
> Actually it doesn't neither on i386. That's because entry.S happens to put
> the arguments both into registers and the stack in the right order, so both
> register and stack argument calling conventions work.
>
> But it is slightly safer to have it. When you use the stack arguments
> the C code is allowed to modify it, and when the system call is restarted
> later you could see garbage. In practice that's not a big issue because
> only very few system calls are restartable.
>
> ptrace also could see corrupted state, but that's in general a non issue.
Ok, thanks for the info, I hope it's applied anyway.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

