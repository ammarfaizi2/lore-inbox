Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbVI0LKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbVI0LKp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 07:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbVI0LKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 07:10:45 -0400
Received: from smtpout4.uol.com.br ([200.221.4.195]:175 "EHLO smtp.uol.com.br")
	by vger.kernel.org with ESMTP id S964900AbVI0LKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 07:10:44 -0400
Date: Tue, 27 Sep 2005 08:10:39 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-kernel@vger.kernel.org
Subject: Strange disk corruption with Linux >= 2.6.13
Message-ID: <20050927111038.GA22172@ime.usp.br>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there. I'm seeing a really strange problem on my system lately and I
am not really sure that it has anything to do with the kernels.

I would appreciate any guidance with my problems. Any help is welcome.

My desktop has a Duron 1.3GHz (but, for some reason, it runs only at
1.1GHz) and an Asus A7V motherboard, with chipset VIA KT133 (not the
enhanced version KT133A).

Its memory modules are all PC133 and it had a 128MB card + 256MB
memory. Then, I decided that it wasn't the right time for a new computer
and just bought myself 2 newer expansion cards of 512MB.

Now, the motherboard has 512MB + 512MB + 256MB (all slots filled). I
then, recompiled the kernels with HIGHMEM support (the 4GB version) and
I've been seeing some strangeness since then.

The first thing that I noticed was that I run some file integrity
programs (debsums, which checks the md5sum signatures of the packages
that I have installed) to check the state of my system. I discovered
that some packages didn't have its signatures matching the originals.

Then, I reinstalled said packages and run debsums again. I got some
*other* packages with md5sum mismatches. Thinking that it could be
something related to the memory of my system, I decided to run
memtest86+ for some time.

After running for 6 hours, it could not find anything wrong with the
1.25GB of memory installed, which left me quite puzzled.

I then tried using the system again, but, still puzzled by the md5sum
mismatches, I tried to verify them again and I got some other packages
with problems.

At the same time, I was trying to stress test the machine a little bit
and decompressing the kernel tree from a tar.bz2 file, since a friend of
mine asked me to compile him a kernel >= 2.6.12 so that he could use
udev.

In the middle of the untarring, bzip2 stopped and said that it found
inconsitencies and that I should run bzip2recover on the file.  I
removed the entire tree and tried uncompressing the tarball again and
the same result happened.

I then decided to reboot the machine, since I was fed up with this
strangeness (that I had never seen occurring before), and after the
boot, I tried running memtest86+ again for some minutes. It didn't find
anything.

Then, I booted back into Linux (at the time I was using 2.6.14-rc2) and
*succeeded* in uncompressing the tar.bz2 file that was "corrupted". At
this point in time, I did not understand anything.

I then left my computer running on memtest86+ while I went to work and
16 hours later, no problem was found and it was still running fine.

I then thought that it could be something with the harddisk and tried to
play with smartctl. I run one long/off-line test on my HD, but it
succeeded (I conjectured that the drive could be running out of spare
sectors).

I also tried running the kernel with highmem=0K, but the symptoms of
corruption repeated themselves. I even thought that maybe Linux couldn't
have been very much exposed to systems with HIGHMEM on older hardware
(like mine) and I then left the machine with just a 512MB card and it
still has problems.

I have voluntary preempt enabled, but I had it before and didn't notice
anything strange. I am now back to kernel 2.6.13.2 (avoiding all the
niceness that is in the 2.6.14-rc's), just to be sure. I can't see many
other things to try, except disabling voluntary preempt (which hasn't
given me any problems with earlier kernels and even -mm kernels).

Other than that, I am stuck and without any ideas. Please, any help
would be much more than welcome.


Thank you very much for suggestions, Rogério Brito.

P.S.: If anybody knows of a live CD with memtest86+ and cpuburn and
other things so that I could test my system, I would be highly
interested to know.

I sincerely don't know if I have a software or a hardware problem here.

P.P.S.: I am using a Debian testing system and the most demanding thing
that I do with my system is to compress some files to MP3 and to type
some texts in LaTeX with Emacs under Fluxbox with the Minimal style
(which is quite easy on the machine---I have not yet dared to use any
heavy desktop environment).

If any information else is desired, please let me know. I will gladly
help you to help me, as I am almost desperate. Thanks.
-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
