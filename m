Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129874AbQKIHGM>; Thu, 9 Nov 2000 02:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129946AbQKIHGD>; Thu, 9 Nov 2000 02:06:03 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:35112 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129874AbQKIHFy>; Thu, 9 Nov 2000 02:05:54 -0500
Message-ID: <3A0A4CBA.ED4DC5C4@linux.com>
Date: Wed, 08 Nov 2000 23:05:30 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@wirex.com>
CC: linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>
Subject: Re: [bug] usb-uhci locks up on boot half the time
In-Reply-To: <3A09F158.910C925@linux.com> <14857.62696.393621.795132@somanetworks.com> <3A09FD81.E7DA9352@linux.com> <20001108200844.A13446@wirex.com> <3A0A25C1.C46E392B@linux.com> <20001108215901.A13572@wirex.com>
Content-Type: multipart/mixed;
 boundary="------------15CC03D8157D5E19F29D5592"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------15CC03D8157D5E19F29D5592
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

More data:

kdb> bp pci_conf1_write_config_word+0x3a
Instruction(i) BP #1 at 0xc01100f2 (pci_conf1_write_config_word+0x3a)
    is enabled globally adjust 1
kdb> go
Instruction(i) breakpoint #1 at 0xc01100f2 (adjusted)
0xc01100f2 pci_conf1_write_config_word+0x3a:   orl    $0xcfc,%edx

Entering kdb (current=0xcfff4000, pid 1) due to Breakpoint @ 0xc01100f2
kdb> ss
0xc01100f2 pci_conf1_write_config_word+0x3a:   orl    $0xcfc,%edx
SS trap at 0xc01100f8 (pci_conf1_write_config_word+0x40)
0xc01100f8 pci_conf1_write_config_word+0x40:   outw   %ax,(%dx)
kdb> rd
eax = 0x00002000 ebx = 0x800022c0 ecx = 0x000000c0 edx = 0x00000cfc
esi = 0x00002000 edi = 0xc144c800 esp = 0xcfff5f68 eip = 0xc01100f8
ebp = 0xcfff5f70 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00000006
xds = 0xcfff0018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xcfff5f34

-d

--
"The difference between 'involvement' and 'commitment' is like an
eggs-and-ham breakfast: the chicken was 'involved' - the pig was
'committed'."



--------------15CC03D8157D5E19F29D5592
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;14688
fn:David Ford
end:vcard

--------------15CC03D8157D5E19F29D5592--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
