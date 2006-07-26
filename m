Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030303AbWGZBBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303AbWGZBBE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 21:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWGZBBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 21:01:04 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:13003 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1030303AbWGZBBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 21:01:02 -0400
Message-Id: <200607260100.k6Q10miJ007619@laptop13.inf.utfsm.cl>
To: 7eggert@gmx.de
cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Joshua Hudson <joshudson@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: what is necessary for directory hard links 
In-Reply-To: Message from Bodo Eggert <7eggert@elstempel.de> 
   of "Tue, 25 Jul 2006 23:28:29 +0200." <E1G5USP-0000fF-Sp@be1.lrz> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Tue, 25 Jul 2006 21:00:48 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 25 Jul 2006 21:00:57 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert <7eggert@elstempel.de> wrote:
> Horst H. von Brand <vonbrand@inf.utfsm.cl> wrote:
> > Joshua Hudson <joshudson@gmail.com> wrote:
> 
> > [...]
> > 
> >> Maybe someday I'll work out a system by which much less is locked.
> >> Conceptually, all that is requred to lock for the algorithm
> >> to work is creating hard-links to directories and renaming directories
> >> cross-directory.
> > 
> > Some 40 years of filesystem development without finding a solution to that
> > conundrum would make that quite unlikely, but you are certainly welcome to
> > try.

> There is a simple solution against loops: No directory may contain a
> directory with a lower inode number.

This is a serious restriction...

> Off cause this would interfere with normal operations, so you'll allocate all
> normal inodes above e.g. 0x800000 and don't test between those inodes.

And allow loops there? I don't see how that solves anything...

> If you want to hardlink, you'll use a different (privileged) mkdir call
> that will allocate a choosen low inode number. This is also required for
> the parents of the hardlinked directories.

Argh... even /more/ illogical restrictions!

> You can also use the generic solution: Allow root to shoot his feet, and
> make sure the gun works correctly.

;-)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
