Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132040AbRBDQXu>; Sun, 4 Feb 2001 11:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRBDQXn>; Sun, 4 Feb 2001 11:23:43 -0500
Received: from [62.122.17.207] ([62.122.17.207]:9485 "EHLO penny")
	by vger.kernel.org with ESMTP id <S132040AbRBDQXa>;
	Sun, 4 Feb 2001 11:23:30 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1 segfault when doing "ls /dev/"
In-Reply-To: <87u26avkfp.fsf@penny.ik5pvx.ampr.org>
	<3A7D5CFB.1C21ECD2@wanadoo.fr> <87lmrmv984.fsf@penny.ik5pvx.ampr.org>
	<3A7D7BCE.37F3DDF@wanadoo.fr>
Reply-To: Pierfrancesco Caci <p.caci@tin.it>
From: Pierfrancesco Caci <ik5pvx@penny.ik5pvx.ampr.org>
Date: 04 Feb 2001 17:28:03 +0100
In-Reply-To: <3A7D7BCE.37F3DDF@wanadoo.fr>
Message-ID: <87g0huv2ek.fsf@penny.ik5pvx.ampr.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

:-> "Pierre" == Pierre Rousselet <pierre.rousselet@wanadoo.fr> writes:


    > /dev is mounted at boot time by the kernel (CONFIG_DEVFS_MOUNT=y).
    > The system boots and runs without devfsd. You just can't start any 
    > process calling for non-existing device under /dev and not created
    > by devfsd. For instance pppd or mc won't start by lack of pseudo-tty 
    > esd needs /dev/dsp ...

Yes I know this. Actually, booting with "devfs=nomount s" is the only
way to update the boot record with lilo and my existing lilo.conf.
If I boot with devfs=nomount, I *can* ls /dev, without segfaulting.
I don't want to access or use any device in /dev, I just want to stat
/dev and see what's inside. There's something wrong with (I suspect)
devfsd and the way it populates /dev with symlinks, whick make /dev
un-listable but still usable, somewhat.


    > i was thinking the trouble may come from some programme launched by
    > your boot scripts before devfsd is running.

I have no idea. Any other debian users reporting this ?

    > is your version of fileutils > 4.0.28 (ls --version) ?

root@penny:/usr/src/linux # ls --version
ls (fileutils) 4.0.37


Pf


-- 

-------------------------------------------------------------------------------
 Pierfrancesco Caci | ik5pvx | mailto:p.caci@tin.it  -  http://gusp.dyndns.org
  Firenze - Italia  | Office for the Complication of Otherwise Simple Affairs 
     Linux penny 2.4.1 #1 Sat Feb 3 20:43:54 CET 2001 i686 unknown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
