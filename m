Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbTDKXgi (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 19:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbTDKXgO (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 19:36:14 -0400
Received: from postoffice2.mail.cornell.edu ([132.236.56.10]:47840 "EHLO
	postoffice2.mail.cornell.edu") by vger.kernel.org with ESMTP
	id S261927AbTDKXem convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 19:34:42 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: ALSA, via 82xx, ALC650, and multichannel output.
Date: Fri, 11 Apr 2003 19:47:46 -0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200304111947.47598.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I attempted posting this to the alsa mailing lists, but I'm not subscribed,
and I think it's waiting for moderator approval. In any case, ALSA being part 
of the kernel, here's my bug report:

This is using the driver from alsa-project on a 2.4 kernel (details below):
============================================================
I'd like to confirm a bug report (follows) on my system:

The System:
        Gigabyte GVAXP-Ultra with onboard RealTek ALC650 soundcard.
        Altec Lansing 251 5.1 surround speaker system (analog)
        Kernel: 2.4.21-pre5-ac3
        Alsa: 0.9.2
        lsmod:
                [root@cobra phantom]# lsmod
                Module                  Size  Used by    Tainted: P
                nvidia               1592672  10  (autoclean)
                snd-pcm-oss            54500   1
                snd-mixer-oss          18456   0  [snd-pcm-oss]
                snd-via82xx            17996   1
                snd-pcm                93920   0  [snd-pcm-oss snd-via82xx]
                snd-timer              22600   0  [snd-pcm]
                snd-ac97-codec         46624   0  [snd-via82xx]
                snd-mpu401-uart         5856   0  [snd-via82xx]
                snd-rawmidi            20960   0  [snd-mpu401-uart]
                snd-seq-device          6796   0  [snd-rawmidi]
                snd                    53380   0  [snd-pcm-oss snd-mixer-oss 
snd-via82xx
snd-pcm snd-timer snd-ac97-codec snd-mpu401-uart snd-rawmidi snd-seq-device]
snd-page-alloc          8984   0  [snd-via82xx snd-pcm]

The Problem:
        My speakers have a switch between 2/4 channels and 6 channels.
        When in 6-channel mode, nothing will play on the center and rear 
speakers, unless I enable Duplicate Front. When in 4 channel mode, all 
speakers play. Apparently, multichannel output isn't working.

Note: I have unmuted almost everything, including
CENTER, SURROUND, LFE....

Additional info:
        I think I compiled with debug on, but I'm not sure anymore.
        I get these messages:

ALSA ../alsa-kernel/pci/via82xx.c:675: invalid via82xx_cur_ptr, using last
valid pointer
ALSA ../alsa-kernel/pci/via82xx.c:675: invalid via82xx_cur_ptr, using last
valid pointer



==============================================================
Original report:

>
> # From: Armando
> # Subject: [Alsa-user] Multichannel in Realtek ACL650 (via_82xx)
> # Date: Tue, 25 Mar 2003 07:44:17 -0800
> Hi:
>         I downloaded ALSA drivers v0.9.0rc6 and I'm using them now. They
work
> correctly, but this Sound card (I have a Gigabyte GA7-VAX mobo) is
> multichannel (up to 6.1) in Windows.
>       I'm currently using 2.1 speakers configuration, but I have 4.1
> speakers, can I enable 4.1 output? Is it possible with current drivers?
> How?
>
>
> P.D.: This soundcard uses the line-in connector for rear speakers. (in
> 4.1 mode).
>
> Thanks for your help.
>
> -=ArCePi=-
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+l1QiXQ/AjixQzHcRAtHrAKCa7DcSDVTfc9DJV0s8KkPA5fb03gCgjlGA
nv6PHR5V6IYmpTU2JK383Ig=
=k7Ym
-----END PGP SIGNATURE-----

