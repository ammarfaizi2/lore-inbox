Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262506AbSIZM13>; Thu, 26 Sep 2002 08:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262507AbSIZM13>; Thu, 26 Sep 2002 08:27:29 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:62223 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262506AbSIZM12>; Thu, 26 Sep 2002 08:27:28 -0400
Message-Id: <200209261204.g8QC4vp04049@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Norbert Nemec <nobbi@theorie3.physik.uni-erlangen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Serious Problems with PCI and SMP
Date: Thu, 26 Sep 2002 14:59:14 -0200
X-Mailer: KMail [version 1.3.2]
References: <20020923155355.GA565@cognac.physik.uni-erlangen.de> <200209240828.g8O8Stp24897@Port.imtp.ilyichevsk.odessa.ua> <20020926090754.GA22448@cognac.physik.uni-erlangen.de>
In-Reply-To: <20020926090754.GA22448@cognac.physik.uni-erlangen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 September 2002 07:07, Norbert Nemec wrote:

BTW, for lkml readers: this was in original post:
=================================================
We have a number of machines with identical dual PPro 200 mainboards. They all
run fine on 2.2.13 kernels. Trying 2.4.18,2.4.19,2.4.20-pre7 and even 2.2.19, 
the same problem shows up:
With SMP activated in the kernel, I get the boot-messages
---------
PCI: PCI BIOS revision 2.10 entry at 0xfb0a0, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
Limiting direct PCI/PCI transfers.
---------
Afterwards, everything runs fine, except that PCI seems to be only half-way
functional: network-cards don't give any error messages but behave just
as if the cable was disconnected scsi-cards give strange errors (don't recall
what exactly)
With SMP disabled in the kernel, everything works just fine.
================================
> > Post your .config and dmesg
>
> Here they are. In this version, CONFIG_PCI_GOBIOS=y is set. Switching to
> CONFIG_PCI_GODIRECT=y or CONFIG_PCI_GOANY=y only adds the line
> ----
>  PCI: PCI BIOS revision 2.10 entry at 0xfb0a0, last bus=0
> +PCI: Using configuration type 1
>  PCI: Probing PCI hardware
> ----
> without any further difference.

> .config:
> ---------------------------
> #
> # Processor type and features
> #
> CONFIG_M686=y

Can you try to boot 486-optimized kernel?
Can you remove one CPU and run SMP kernel on UP configuration?
--
vda
