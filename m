Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267268AbTAVB5C>; Tue, 21 Jan 2003 20:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267275AbTAVB5C>; Tue, 21 Jan 2003 20:57:02 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:8204 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S267268AbTAVB5B>; Tue, 21 Jan 2003 20:57:01 -0500
Message-ID: <3E2DFC78.1040402@snapgear.com>
Date: Wed, 22 Jan 2003 12:05:44 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: common RODATA in vmlinux.lds.h (2.5.59)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The new common definition of RODATA for linker scripts
(in include/asm-generic/vmlinux.lds.h) is causing me some
amount of pain, at least on the m68knommu architecture.

The problem is that on the m68knommu arch linker script
it fundamentaly groups everything into 2 memory regions,
one for flash and one for ram. Each section is then
directed to the appropriate memory region, eg:

         .text : {
             *(.text)
         } > flash

With the way the RODATA define is setup I cannot do this.
It contains definitions for a number of complete sections.

Anyone got any ideas on the best way to fix this?

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com





