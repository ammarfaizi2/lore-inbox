Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265487AbUIUWdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265487AbUIUWdJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 18:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266585AbUIUWdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 18:33:09 -0400
Received: from mailgw3.technion.ac.il ([132.68.238.35]:8856 "EHLO
	mailgw3.technion.ac.il") by vger.kernel.org with ESMTP
	id S265487AbUIUWdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 18:33:04 -0400
Date: Wed, 22 Sep 2004 00:33:00 +0200 (IST)
From: Alon Altman <alon@8ln.org>
X-X-Sender: alon@alon1.dhs.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ICH5 SATA problem loading ide-cd module
In-Reply-To: <1095797341.31593.11.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0409220027570.3228@alon1.dhs.org>
References: <Pine.LNX.4.61.0409212317570.2932@alon1.dhs.org>
 <1095797341.31593.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sep 2004, Alan Cox wrote:

> On Maw, 2004-09-21 at 21:23, Alon Altman wrote:
>> Please Cc me to any replies, as I'm not subscribed to LKML.
>
> Firstly try booting with "acpi=off"

Just tried it. I get a kernel oops (copied via paper):

Undable to handle kernel null pointer dereference at virtual address 0000000c

eip: c01a1a7f
*pde=0
Oops: 0000[#1]
PREEMPT SMP
Modules linked in: ata_piix libata scsi_mod unix font vesafb cfbcopyarea
                    cfbimgblt cfbfillrect
CPU: 0
EIP: 0060:[<c01a1a7f>]
EFLAGS: 00010286
EIP is at sysfs_hash_and_remove+0xf
EAX: 00000000 EBX: f8876744 ECX: c02b4306 EDX: ffff0001
ESI: 00000000 EDI: f88766e0 EBP: f8876744 ESP: f7eb7d9c

Process modprobe

Call Trace:
c0209d2b class_device_dev_unlink
c020a3fe          .
                   .
                   .
f882200f piix_init
                   .
                   .
                   .

If you need more of the call trace, I can copy more via paper...

Thanks,
   Alon

-- 
This message was sent by Alon Altman (alon@alon.wox.org) ICQ:1366540
GPG public key at http://8ln.org/pubkey.txt
Key fingerprint = A670 6C81 19D3 3773 3627  DE14 B44A 50A3 FE06 7F24
--------------------------------------------------------------------------
  -=[ Random Fortune ]=-
If you stand on your head, you will get footprints in your hair.
