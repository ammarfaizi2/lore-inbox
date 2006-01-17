Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWAQSHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWAQSHI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWAQSHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:07:08 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:62774 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932280AbWAQSHG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:07:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fwzDAnea8TWFZbzbQyQUpLQRJ2HZZ6J+hhmbboUAyFpV46vqBlS7bLiFK9BvlaHdN1bJ/SgxyZQ8MHy3YuWeSKE/A84QN5QDYpsICef3X6CLybfXU6WMi6tcFygeQ9mA23xctML71Wc3CxTztC1ypQBeE10dOB08kS2ICeGpcyM=
Message-ID: <9a8748490601171007y426a02baq786d07a86f1632f7@mail.gmail.com>
Date: Tue, 17 Jan 2006 19:07:04 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Diego Calleja <diegocg@gmail.com>
Subject: Re: [KORG] GITWEB doesn't show any DIFF's
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>, mkrufky@m1k.net,
       webmaster@kernel.org, linux-kernel@vger.kernel.org, mkrufky@gmail.com
In-Reply-To: <20060117185244.e7b5cffc.diegocg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <43CCF8BB.1050009@m1k.net>
	 <200601171739.17168.s0348365@sms.ed.ac.uk>
	 <20060117185244.e7b5cffc.diegocg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/06, Diego Calleja <diegocg@gmail.com> wrote:
> El Tue, 17 Jan 2006 17:39:17 +0000,
> Alistair John Strachan <s0348365@sms.ed.ac.uk> escribió:
>
> > Seems to work for me right _now_, could you verify that this is still
> > happening?
>
>
> It happens for me, too - instead of showing me the diff, diffstat
> shows me just:
>
>
> file:844a6c9fb9490e585fc5371d759840b9e7ae327c -> file:21965e5ef25e8c1c86bd59da0f40350d4f821702
> file:9a96f05883935a32955b216fcc3184bf162b0a85 -> file:63dd184ec808e7129efc3a355abdba4a21bf2c81
>
> With this commitdiff link, for example:
> http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=7fab773de16ccaeb249acdc6e956a9759c68225d;hp=0046b06a367cd853efd3223ce60143f3a7952522

Seems to work just fine for me.
With that link I get this :



[PATCH] ide: AMD Geode GX/LX support
From: "Jordan Crouse" <jordan.crouse@amd.com>

The core IDE engine on the CS5536 is the same as the other AMD southbridges,
so unlike the CS5535, we can simply add the appropriate PCI headers to
the existing amd74xx code.


file:844a6c9fb9490e585fc5371d759840b9e7ae327c ->
file:21965e5ef25e8c1c86bd59da0f40350d4f821702
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -74,6 +74,7 @@ static struct amd_ide_chip {
{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE, 0x50, AMD_UDMA_133 },
{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE, 0x50, AMD_UDMA_133 },
{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE, 0x50, AMD_UDMA_133 },
+ { PCI_DEVICE_ID_AMD_CS5536_IDE, 0x40, AMD_UDMA_100 },
{ 0 }
};
@@ -491,6 +492,7 @@ static ide_pci_device_t amd74xx_chipsets
/* 14 */ DECLARE_NV_DEV("NFORCE-MCP04"),
/* 15 */ DECLARE_NV_DEV("NFORCE-MCP51"),
/* 16 */ DECLARE_NV_DEV("NFORCE-MCP55"),
+ /* 17 */ DECLARE_AMD_DEV("AMD5536"),
};
static int __devinit amd74xx_probe(struct pci_dev *dev, const struct
pci_device_id *id)
@@ -527,6 +529,7 @@ static struct pci_device_id amd74xx_pci_
{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14 },
{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15 },
{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16 },
+ { PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 17 },
{ 0, },
};
MODULE_DEVICE_TABLE(pci, amd74xx_pci_tbl);
file:9a96f05883935a32955b216fcc3184bf162b0a85 ->
file:63dd184ec808e7129efc3a355abdba4a21bf2c81
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -487,6 +487,8 @@
#define PCI_DEVICE_ID_AMD_8151_0 0x7454
#define PCI_DEVICE_ID_AMD_8131_APIC 0x7450
+#define PCI_DEVICE_ID_AMD_CS5536_IDE 0x209A
+
#define PCI_VENDOR_ID_TRIDENT 0x1023
#define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX 0x2000
#define PCI_DEVICE_ID_TRIDENT_4DWAVE_NX 0x2001


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
