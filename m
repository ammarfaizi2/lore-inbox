Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbVKAPs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbVKAPs2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 10:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbVKAPs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 10:48:28 -0500
Received: from nwd2mail3.analog.com ([137.71.25.52]:23434 "EHLO
	nwd2mail3.analog.com") by vger.kernel.org with ESMTP
	id S1750908AbVKAPs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 10:48:27 -0500
Message-Id: <6.1.1.1.0.20051101075832.01ebc3b0@ptg1.spd.analog.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Tue, 01 Nov 2005 10:48:07 -0500
To: Jacques Moreau <jacques.moreau@imag.imag.fr>
From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: ADI Blackfin porting for kernel-2.6.13
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 10/22/2005, Jacques asked:
>Does this patch is only for Blackfin processor or it add some support for 
>fusiv [1] communications processor that are in residential Gateway ?

The Blackfin/uClinux 2.6.x patch which was prepared (and will be 
maintained) by a separate team(1) who is not working on any fusiv 
processors (which are MIPS-based).

>If no, do you know if analog plans to realease the linux 2.4/2.6 
>modification that have been made in order to support these processors ?

Not sure - Since the two groups are separate, no one on the team here knows 
the plans of the Fusiv team.

>IRRC some Sagem residential Gateways (will) run on Linux OS and the users 
>sould be able ask for the GPL code.

So, the best place to go would be to Sagem (or any company shipping a 
product with Embedded Linux/uClinux). Since they are responsible for 
distributing the binary, it is their responsibility to make the source 
released under GPL or derived from previously GPL'ed software available.

If you received a product from Sagem, which you believe includes GPL'ed 
software - call them and ask for the source:
http://www.sagem.com/index.php?id=445&L=0

If you received a development kit, or other reference design from ADI, 
which you believe includes GPL'ed software, call them and ask for the source:
http://www.analog.com/salesdir/continent.asp

Thanks
-Robin

<shameless plug>
(1)There is a small group of open source developers inside of ADI, focusing 
on the support of the Blackfin processor with various open source projects. 
We have people dedicated to:
  - the FSF's Toolchain (gcc, gdb, binutils) where our patches have
     been accepted into the mainline projects (still working on the
     last kinks gdb pthreads support).
  - Das U-Boot as our chip initialization and bootloader. Booting from the
     network is very powerful in many embedded environments.
  - the GNU/uClinux kernel (Luke's recent patch for 2.6.14), where end
     products are beginning to ship in volume.
  - open source hardware design - free (speech) software isn't any good
     on closed hardware. All of our schematics, gerbers, PCB manufacturing
     files are released under the GPL, and are mostly avalible from
     Digikey, at sub $225 price points.
  - Simulation support with Skyeye
     http://gro.clinux.org/forum/forum.php?forum_id=2619

Our team completely embraces the open source model (release early, release 
often) - using open source tools (GForge, Tinderbox, cvs, dokuwiki), 
publishing everything we do/understand on the web(2). We have been 
responsible for contributions in other open source projects:
   - helped port Linux Test Project (LTP) so it could run on a
      uClinux/uclibc/no-mmu environment
   - helped port Speex to the Blackfin, to run a completely open
       source embedded VoIP phone, based on Linphone.
   - helping update uClinux-dist to other main-line projects.
   - others, but I am starting to get a little wordy.

The combination of Blackfin/uClinux is pretty compelling - the hardware(3) 
has a pretty good span of price(as low as $4.95)/performance(BF561 include 
Dual Core, 600MHz each) & I won't go into the benefits of uClinux and open 
source here :)

If anyone is interested in looking at things running on real hardware, I do 
have a limited amount of hardware I can lend people for poking/porting. 
Some of the things we have working are pretty cool[4]. Send me a private email.

</shameless plug>

[2]http://blackfin.uclinux.org
[2]http://docs.blackfin.uclinux.org
[2]http://cvs.blackfin.uclinux.org
[3]http://www.analog.com/processors/processors/blackfin/index.html
[4]http://www.linuxdevices.com/articles/AT9272421886.html 

