Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263606AbUAIRab (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 12:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbUAIRaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 12:30:30 -0500
Received: from sloth.wcug.wwu.edu ([140.160.139.223]:36625 "HELO
	sloth.wcug.wwu.edu") by vger.kernel.org with SMTP id S263606AbUAIRaS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 12:30:18 -0500
Date: Fri, 9 Jan 2004 09:33:36 -0800 (PST)
From: josh-lkernel@wcug.wwu.edu
X-X-Sender: josh@sloth.wcug.wwu.edu
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
cc: Valdis.Kletnieks@vt.edu, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: What SCSI in the IBM?
In-Reply-To: <20040109152016.GH24295@rdlg.net>
Message-ID: <Pine.LNX.4.58.0401090921180.25118@sloth.wcug.wwu.edu>
References: <20040109150512.GF24295@rdlg.net> <200401091515.i09FFSDM030918@turing-police.cc.vt.edu>
 <20040109152016.GH24295@rdlg.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a few x345s at work.  This should help.

It is a LSI Logic / Symbios Logic (formerly NCR) card.

Here are the SCSI files that I know are =y in my .config:

CONFIG_SCSI=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_AACRAID=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_SCSI_DPT_I2O=y
CONFIG_SCSI_G_NCR5380_PORT=y
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_PQS_PDS=y
CONFIG_SCSI_DC390T=y
CONFIG_SCSI_PCMCIA=y
CONFIG_I2O_SCSI=y

Sorry this list is not a clean as I would like.

I also know there is a debian add-on disk with the needed modules for this
card, but I don't have an extra machine to try that on right now to look
them up.

jlogan@host:~$ cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: LSILOGIC Model: 1030 IM          Rev: 1000
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 08 Lun: 00
  Vendor: IBM      Model: 32P0032a S320  1 Rev: 1
  Type:   Processor                        ANSI SCSI revision: 02

jlogan@host:~$ lspci
00:00.0 Host bridge: ServerWorks: Unknown device 0014 (rev 32)
00:00.1 Host bridge: ServerWorks: Unknown device 0014
00:00.2 Host bridge: ServerWorks: Unknown device 0014
00:06.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:0f.0 Host bridge: ServerWorks CSB5 South Bridge (rev 93)
00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 05)
00:0f.3 ISA bridge: ServerWorks: Unknown device 0225
00:10.0 Host bridge: ServerWorks: Unknown device 0101 (rev 05)
00:10.2 Host bridge: ServerWorks: Unknown device 0101 (rev 05)
00:11.0 Host bridge: ServerWorks: Unknown device 0101 (rev 05)
00:11.2 Host bridge: ServerWorks: Unknown device 0101 (rev 05)
06:08.0 Ethernet controller: Intel Corp.: Unknown device 1010 (rev 01)
06:08.1 Ethernet controller: Intel Corp.: Unknown device 1010 (rev 01)
08:07.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR)
53c1030 (rev 07)
08:07.1 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR)
53c1030 (rev 07)


Hope this helps.

							Later, JOSH


On Fri, 9 Jan 2004, Robert L. Harris wrote:

>
> Thus spake Valdis.Kletnieks@vt.edu (Valdis.Kletnieks@vt.edu):
>
> > On Fri, 09 Jan 2004 10:05:12 EST, "Robert L. Harris" <Robert.L.Harris@rdlg.net>  said:
> >
> > > The network cards in this IBM came up great once I found the right port.
> > > Now though I'm trying to find what SCSI driver to use.
> >
> > What IBM?  Laptop? PC? Netfinity? RS6K? e/i/p/z-series?
>
> Ok, I found the "isa-pnp" module which fixed the unresolved module but
> now the sym driver also just give no device errors.  This is a 2U Xeon
> "eServer" model number x345.
>
>
> :wq!
> ---------------------------------------------------------------------------
> Robert L. Harris                     | GPG Key ID: E344DA3B
>                                          @ x-hkp://pgp.mit.edu
> DISCLAIMER:
>       These are MY OPINIONS ALONE.  I speak for no-one else.
>
> Life is not a destination, it's a journey.
>   Microsoft produces 15 car pileups on the highway.
>     Don't stop traffic to stand and gawk at the tragedy.
>
