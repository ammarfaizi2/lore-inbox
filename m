Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbVILFJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbVILFJv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 01:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVILFJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 01:09:51 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:42186 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751141AbVILFJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 01:09:51 -0400
Message-Id: <200509120213.j8C2DVTK014972@inti.inf.utfsm.cl>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [2.6-GIT] NTFS: Release 2.1.24. 
In-Reply-To: Message from Anton Altaparmakov <aia21@cam.ac.uk> 
   of "Sat, 10 Sep 2005 14:28:49 +0100." <Pine.LNX.4.60.0509101424260.20200@hermes-1.csi.cam.ac.uk> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Sun, 11 Sep 2005 22:13:31 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> On Sat, 10 Sep 2005, Giuseppe Bilotta wrote:

[...]

> > BTW Anton, while looking for the best permission masks to be used when
> > mounting my NTFS paritions, I spotted what I think is a bug, or at
> > least an inconsistency between the way all fs drivers I use handle
> > umasks & friends, and the way NTFS does it. Basically, all the other
> > fs drivers take an octal representation of the masks. NTFS, instead,
> > seems to use _decimal_

> NTFS takes any.  It is happy with octal, decimal, and hex.  The ntfs 
> driver uses linux/lib/vsprintf.c::simple_strtoul() with a zero base which 
> autodetects which base to use so if you use umask=0222 it will take this 
> as octal and if you use umask=222 it will take this as decimal and if you 
> use 0x222 it will take this as decimal.

> I do not see what is wrong with that.  It behaves exactly like I would 
> expect it to.  Maybe I have strange expectations?  (-;

At least chmod(1) takes /only/ octal, so 666 isn't the number of the beast,
but plain rw for everybody ;-)

I think this should be consistent with that.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

