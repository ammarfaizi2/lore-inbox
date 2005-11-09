Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965280AbVKIIHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965280AbVKIIHl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 03:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965284AbVKIIHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 03:07:41 -0500
Received: from netzweb.gamper-media.ch ([157.161.128.137]:55310 "EHLO
	ns1.netzweb.ch") by vger.kernel.org with ESMTP id S965280AbVKIIHk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 03:07:40 -0500
From: "Miro Dietiker, MD Systems" <info@md-systems.ch>
To: <linux-kernel@vger.kernel.org>
Cc: "'Denis Vlasenko'" <vda@ilport.com.ua>
Subject: AW: Compiling kernel for amd 8131 chipset
Date: Wed, 9 Nov 2005 09:07:22 +0100
Organization: MD Systems
Message-ID: <02db01c5e504$9e11e550$4001a8c0@MDSYSPORT>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <200511081804.10761.vda@ilport.com.ua>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
X-yoursite-MailScanner-Information: Please contact the ISP for more information
X-yoursite-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Back again: Kernel 2.6.12.6 works well for my system.
Compiling the most ~similar 2.6.14 selections as 2.6.12.6 is not
recognizing the 8131 chipset.
(I'm using default values for all new modules)

lsmod shows mostly the same result.

Any suggestion or reasons for "no longer supported 8131"?

+-------------------------------+  +-------------------------------+
| Miro Dietiker                 |  | MD Systems Miro Dietiker      |
+-------------------------------+  +-------------------------------+


-----Ursprüngliche Nachricht-----
Von: Denis Vlasenko [mailto:vda@ilport.com.ua] 
Gesendet: Dienstag, 8. November 2005 17:04
An: Miro Dietiker, MD Systems
Betreff: Re: Compiling kernel for amd 8131 chipset

On Tuesday 08 November 2005 17:48, Miro Dietiker, MD Systems wrote:
> Hi there
> 
> I've got a Tyan 2891 Barebone here and tried to compile kernel with
> support for AMD 8131 PCI-X Controller
> (Since via this controller a network-chip bcm5704 is connected
on-board)
> 
> Link to chipset overview:
>
http://www.amd.com/us-en/Processors/TechnicalResources/0,,30_182_871_903
> 4%5E9504,00.html
> Link to patch:
>
http://cdrom.amd.com/21860/updates/opteron_drivers/linux/amdshpc-1.1.9.t
> ar.gz
> This patch is described to be for 2.6.11.9 but I'm not able to compile
> support for my 8131 (and sure the NIC as effect)
> I tried multiple Kernels (such as 2.6.14, 2.6.12, 2.6.11.9)
> 
> My last try (2.6.14) resulted in the error message:
> insmod amdshpc.ko
> amdshpc: Unknown symbol reparent_to_init
> insmod: error inserting '/lib/modules/2.6.14/...': -1 Unknown symbol
in
> module

Most probably you have module/kernel version mismatch.

> I couldn't find any thread about this topic.
> Surprisingly if I start "knoppix 3.91 with 2.6.11" the chipset is
being
> detected (lspci)

<joke>
Apparently support for the 8131 was added sometime before 2.8.11 kernel
release.
</joke>

> Do you have any idea for doing that?

Take knoppix's .config and compile latest 2.6 using it (with "make
oldconfig"
step as usual).
--
vda

