Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268746AbUILPNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268746AbUILPNt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 11:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268751AbUILPNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 11:13:49 -0400
Received: from ms002msg.fastwebnet.it ([213.140.2.52]:16595 "EHLO
	ms002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S268746AbUILPNk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 11:13:40 -0400
From: Willy Gardiol <willy@gardiol.org>
Reply-To: willy@gardiol.org
To: Alexander Nyberg <alexn@dsv.su.se>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: PROBLEM:  gzip locks while decompressing a particular file when on NFS v.3
Date: Sun, 12 Sep 2004 17:13:35 +0200
User-Agent: KMail/1.6.2
References: <200409121459.23856.willy@gardiol.org> <1094996694.1421.1.camel@boxen>
In-Reply-To: <1094996694.1421.1.camel@boxen>
MIME-Version: 1.0
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       WilIy Gardiol <willy@gardiol.org>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409121713.37962.willy@gardiol.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I will try with 2.6.8.1 as soon as i can, meanwhile, i have discovered that 
the problem is resolved if i add the "tcp" option to the mount line.

I am downloading 2.6.8.1 right now...

The strace of gunzip is located at the following URL (it is about 100kb i am 
not attaching it at the mail):

"http://www.gardiol.org/strace.gzip"

I did many tests with different zipped files, this is the only case it fails.


Alle Sunday 12 September 2004 15:44, hai scritto:
> > kernel version: 2.6.8
> >
> > Trigger: grab that file from xfree86 ftp site and decompress on a NFS
> > mounted filesystem
> >
> > Environment:
> > Linux shimitar 2.6.8-gentoo-r3 #1 Tue Aug 31 17:35:53 CEST 2004 i686
> > Mobile AMD Athl AuthenticAMD GNU/Linux
> >
> > Gnu C                  3.3.4
> > Gnu make               3.80
> > binutils               2.14.90.0.8
> > util-linux             2.12
> > mount                  2.12
> > module-init-tools      3.0
> > e2fsprogs              1.35
> > nfs-utils              1.0.6
> > Linux C Library        2.3.3
> > Dynamic linker (ldd)   2.3.3
> > Procps                 3.1.15
> > Net-tools              1.60
> > Kbd                    1.12
> > Sh-utils               5.2.1
> > Modules Loaded         nvidia lp vmnet parport_pc parport vmmon
> > snd_seq_midi snd_emu10k1_synth snd_emux_synth snd_seq_virmidi
> > snd_seq_midi_emul snd_emu10k1 snd_rawmidi snd_ac97_codec snd_util_mem
> > snd_hwdep snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device
> > snd_pcm_oss snd_pcm snd_page_alloc snd_timer snd_mixer_oss snd rtl8150
> > 8139too thermal fan processor button battery ac bttv evdev tuner tvaudio
> > video_buf i2c_algo_bit v4l2_common btcx_risc videodev soundcore usbhid
> > via686a w83781d i2c_sensor i2c_isa i2c_core usblp usb_storage ohci_hcd
> > ehci_hcd uhci_hcd usbcore sg sd_mod ide_scsi ide_cd sr_mod cdrom
> > "
>
> 2.6.8 had some bug in nfs, please use 2.6.8.1 or 2.6.9-rc1, and test it
> over again, without tainting the kernel (you at least have nvidia module
> in there).

- --

!
 Willy Gardiol - willy@gardiol.org
 www.gardiol.org
 +39 3492800983
 Use linux for your freedom.

    "Unix _IS_ user friendly -
     it's just selective about
 who its friends are !"

    "Unix _E'_ semplice da usare -
     è solo molto selettivo nei confronti
           di chi siano i suoi amici !"

      Martin Spott (2002)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBRGefQ9qolN/zUk4RAhjhAJsF2ilLn0yDRieM9XIuXZH2NwbTKgCdG963
yRIGJG84LnjXul33Z15b/Cs=
=ThsI
-----END PGP SIGNATURE-----
