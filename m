Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279963AbRKFSyS>; Tue, 6 Nov 2001 13:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280014AbRKFSyI>; Tue, 6 Nov 2001 13:54:08 -0500
Received: from cc76797-a.ensch1.ov.nl.home.com ([213.51.205.95]:31748 "EHLO
	jumbo.ceram119") by vger.kernel.org with ESMTP id <S279963AbRKFSx4>;
	Tue, 6 Nov 2001 13:53:56 -0500
Date: Tue, 6 Nov 2001 19:54:20 +0100
From: "Dennis J.A. Bijwaard" <bijwaard@bijwaard.dhs.org>
To: linux-kernel@vger.kernel.org
Subject: kernel panic smp & usb scanner
Message-ID: <20011106195420.A18732@jumbo.ceram119>
Reply-To: bijwaard@home.nl
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I repeatedly get kernel panics when I try to use my usb scanner. As my
scanner is not specified in /usr/src/linux/drivers/usb/scanner.h, I
added it myself at the end of scanner_device_ids as:
    /* Compeye simplex / Trust combiscan / Powervision Technologies Inc.  */
        { USB_DEVICE(0x05cb, 0x1483) }, /* compeye simplex */

I've attached the kernel panic info from kernel 2.4.14, with and without
processing by ksymoops
-- 
Kind regards,
                   Dennis Bijwaard

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="README.scanner-2.4.14"

[hp] scsi_flush writing 2 bits
[hp] 0x0000 1B 45                       .E
invalid operand 0000
CPU: 1
EIP: 0010: [<c0114b1a>] not tainted
FLAGS: 00010282
eax: 000000018   ebx: c6c15a20   ecx: 00000097   edx: 01000000
esi: c5aca5edc   edi: c5ca4000   ebp: c5ca5ec8   esp: c5ca5e8c
ds: 0018 es: 0018 ss: 0018
Process dnetc(pid: 825,stackpage=c5ca5000)
Stack: c0221f96 c718b260 c5ca5edc c5ca4000 00000000 00000000 00010000 c73efded
       c0276b40 eb7278d4 017078d4 00000002 00000002 00000001 c5ca5edc c62cd380
       c015ab4 c19fda68 c718b1e8 00000001 00000001 c5ca4000 c718b26c c718b262
Call Trace: [<c0105ab4>] [<c0105dc50>] [<c9oe9dd5>] [<c90dd37a>] [<c90dd6d9>] [<c011efd5>] [<c90dd95a>] [<c0108411>] [<c01086c6>] [<c010a648>]

Code: 0f 0b 8d 65 c8 5b 5e 5f 89 ec 5d c3 89 f6 55 89 e5 83 ec 10
<o>kernel panic: Aiee, killing interrupt handler!
In interupt handler - not syncing

--3V7upXqbjpZ4EhLz--
