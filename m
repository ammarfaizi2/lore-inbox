Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313194AbSDYPjZ>; Thu, 25 Apr 2002 11:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313201AbSDYPjY>; Thu, 25 Apr 2002 11:39:24 -0400
Received: from TK212017087078.teleweb.at ([212.17.87.78]:57473 "EHLO
	elch.elche") by vger.kernel.org with ESMTP id <S313194AbSDYPjY>;
	Thu, 25 Apr 2002 11:39:24 -0400
Date: Thu, 25 Apr 2002 17:41:24 +0200
From: FonkiE <fonkie@fsmat.at>
To: Ben Collins <bcollins@debian.org>
Cc: FonkiE <fonkie@fsmat.at>, linux1394-user@lists.sourceforge.net,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: problems with sbp2 and sd_mod (ipod firewire harddisk)
Message-ID: <20020425174124.A4588@elch.elche>
In-Reply-To: <3CC81A29.3050204@fsmat.at> <20020425152328.GD508@blimpo.internal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!
 
> > i have an ipod too. yesterday everything worked fine. today i updated
> > from firmware 1.02 to 1.1. now the system crashed with 'modprobe sbp2'.
> 
> See our website for obtaining the latest source. There are a lot of
> changes to ohci1394 and sbp2 that have so far fixed every known issue
> with sbp2 devices.

thanks that worked:

Apr 25 17:37:52 elch kernel: ohci1394: $Rev: 460 $ Ben Collins <bcollins@debian.org>
Apr 25 17:37:52 elch kernel: PCI: Found IRQ 11 for device 00:0d.0
Apr 25 17:37:52 elch kernel: ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[efffe000-effff000]  Max Packet=[2048]
Apr 25 17:37:53 elch kernel: ieee1394: Device added: Node[00:1023]  GUID[000a27000201e05c]  [Apple Computer, Inc.]
Apr 25 17:37:53 elch kernel: ieee1394: Host added: Node[01:1023]  GUID[009096000000036a]  [Linux OHCI-1394]
Apr 25 17:37:53 elch /sbin/hotplug: no runnable /etc/hotplug/ieee1394.agent is installed
Apr 25 17:38:23 elch kernel: ieee1394: sbp2: Logged into SBP-2 device
Apr 25 17:38:23 elch kernel: ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
Apr 25 17:38:23 elch kernel: scsi3 : IEEE-1394 SBP-2 protocol driver (host: ohci1394)
Apr 25 17:38:23 elch kernel: $Revision: 1.0 $ James Goodwin <jamesg@filanet.com>
Apr 25 17:38:23 elch kernel: SBP-2 module load options:
Apr 25 17:38:23 elch kernel: - Max speed supported: S400
Apr 25 17:38:23 elch kernel: - Max sectors per I/O supported: 255
Apr 25 17:38:23 elch kernel: - Max outstanding commands supported: 8
Apr 25 17:38:23 elch kernel: - Max outstanding commands per lun supported: 1
Apr 25 17:38:23 elch kernel: - Serialized I/O (debug): no
Apr 25 17:38:23 elch kernel: - Exclusive login: yes
Apr 25 17:38:23 elch kernel:   Vendor: Apple     Model: iPod              Rev: 1.10
Apr 25 17:38:23 elch kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Apr 25 17:38:23 elch kernel: Attached scsi removable disk sda at scsi3, channel 0, id 0, lun 0
Apr 25 17:38:23 elch kernel: SCSI device sda: 9780750 512-byte hdwr sectors (5008 MB)
Apr 25 17:38:23 elch kernel: sda: test WP failed, assume Write Enabled
Apr 25 17:38:24 elch kernel:  sda: [mac] sda1 sda2 sda3

when is this scheduled for the main kernel? is it already in a pre-patch?

CU,
	FonkiE
--
fonkie@fsmat.at                         pgp public key on request        CU
