Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131861AbRA3B7w>; Mon, 29 Jan 2001 20:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132121AbRA3B7m>; Mon, 29 Jan 2001 20:59:42 -0500
Received: from selene.cps.intel.com ([192.198.165.10]:56842 "EHLO
	selene.cps.intel.com") by vger.kernel.org with ESMTP
	id <S131861AbRA3B7i>; Mon, 29 Jan 2001 20:59:38 -0500
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE601@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Adam Huffman'" <bloch@verdurin.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.0-test12: SiS pirq handling..
Date: Mon, 29 Jan 2001 17:59:13 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Despite the latest ACPI update, I still get the ACPI slowdown on
> initialisation which started with the -pre10 changes.  Also, the uhci
> module doesn't work for me (the latest patch from Johannes 
> Erdfelt does
> work).  This is an Abit KA7-100, which has the KX133 chipset.  Here is
> the dmesg output for this kernel (I had to turn off ACPI in 
> the BIOS in
> order to have a usable system):

Hi Adam. I am working right now on improving acpi idle. However, I'm
somewhat confused by the trace below which includes:

> ACPI: System description tables not found

The ACPI driver's thread *should* then exit, and never register as the idle
handler. My next update will also have some more diagnostic printk's so
hopefully that will help, because right now I can't see how we can be
failing to find tables, yet still registering as the idle handler.

I'll look at it tomorrow morning, and maybe then it will be obvious. ;-)

Regards -- Andy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
