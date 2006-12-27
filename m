Return-Path: <linux-kernel-owner+w=401wt.eu-S932573AbWL0Ukk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbWL0Ukk (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 15:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWL0Ukj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 15:40:39 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:58184 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754727AbWL0Ukj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 15:40:39 -0500
Message-Id: <200612272038.kBRKcosK021701@laptop13.inf.utfsm.cl>
To: Adrian Bunk <bunk@stusta.de>
cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, davem@davemloft.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sparclinux@vger.kernel.org
Subject: Re: 2.6.19 (current from git) on SPARC64: Can't mount / 
In-Reply-To: Message from Adrian Bunk <bunk@stusta.de> 
   of "Mon, 18 Dec 2006 04:20:03 BST." <20061218032003.GU10316@stusta.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Wed, 27 Dec 2006 17:38:50 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Wed, 27 Dec 2006 17:38:51 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
> On Wed, Dec 13, 2006 at 03:56:46PM -0300, Horst H. von Brand wrote:
> > I've been running kernel du jour straight from git on my SPARC Ultra 1 for
> > some time now on Aurora Corona (Fedora relative, development branch). For a
> > few days now 2.6.19 panics on boot, it can't mount /. 2.6.19 worked fine,
> > as does 2.6.19.1 (Aurora changed gcc, mkinitrd, ... in between, so I had to
> > rebuild a kernel to check if the problem lay elsewhere). Unpacking the
> > initrds for 2.6.19 and 2.6.19.1 shows the same (nash script) /init and the
> > same modules in both (ext3 + jbd, scsi_mod, sd_mod, esp, others).

> > I'm stumped. Any clue?

> Is this issue still present in the latest -git?

Sorry, got sidetracked by other stuff.

Still no boot with 2.9.20-rc1 and -rc2, and none of the kernels I tried in
between.

initrd is sane (the only differences between the one built for working
2.6.19.1 and broken 2.6.20-rc2 are among the modules themselves). What I
did was:

  cd /tmp
  mkdir ird-$version
  cd ird-$version
  zcat /boot/initrd-$version.img | cpio -i

and then "diff -Nur ird-$1 ird-$2". Now to teach diff(1) to compare devices
reasonably...

Tried latest from Fedora rawhide (mkinitrd-6.0.6-1), no boot. initrd is
huge, so I went back to mkinitrd-5.1.19-1.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513

