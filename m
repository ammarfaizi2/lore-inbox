Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263140AbTEBTxw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 15:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263160AbTEBTxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 15:53:52 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:19165 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP id S263140AbTEBTxt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 15:53:49 -0400
Subject: Re: 2.5.68-mm4
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20030502020149.1ec3e54f.akpm@digeo.com>
References: <20030502020149.1ec3e54f.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1051905879.2166.34.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 02 May 2003 14:04:39 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-02 at 03:01, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.68/2.5.68-mm4/
> 
> . Much reworking of the disk IO scheduler patches due to the updated
>   dynamic-disk-request-allocation patch.  No real functional changes here.
> 
> . Included the `kexec' patch - load Linux from Linux.  Various people want
>   this for various reasons.  I like the idea of going from a login prompt to
>   "Calibrating delay loop" in 0.5 seconds.
> 
>   I tried it on four machines and it worked with small glitches on three of
>   them, and wedged up the fourth.  So if it is to proceed this code needs
>   help with testing and careful bug reporting please.
> 

For what it's worth, kexec has worked for me on the following
two systems.

single P-III 933Mhz, 256MB, IDE (system 1)

00:00.0 Host bridge: Intel Corp. 82810E DC-133 GMCH [Graphics Memory Controller Hub] (rev 03)
00:01.0 VGA compatible controller: Intel Corp. 82810E DC-133 CGC [Chipset Graphics Controller] (rev 03)
00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02)
00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02)
00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02)
00:1f.3 SMBus: Intel Corp. 82801AA SMBus (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801AA AC'97 Audio (rev 02)
01:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)


dual P-III 1000Mhz, 1024MB, SCSI (system 2)

00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
00:02.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC] (rev 7a)
00:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
01:04.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
01:04.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)

The times for reboot back to run level 3 are:

		normal		kexec
system 1	 69 seconds	35 seconds
system 2	150 seconds	75 seconds

Steven


