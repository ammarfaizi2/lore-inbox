Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312859AbSDBRYq>; Tue, 2 Apr 2002 12:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312862AbSDBRYg>; Tue, 2 Apr 2002 12:24:36 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:16310 "HELO atlrel8.hp.com")
	by vger.kernel.org with SMTP id <S312859AbSDBRYY>;
	Tue, 2 Apr 2002 12:24:24 -0500
Date: Tue, 2 Apr 2002 10:20:46 -0700
From: Troy Heber <troyh@fc.hp.com>
To: linux-kernel@vger.kernel.org
Subject: WARNING: unexpected IO-APIC on 2.4.19-pre4-ac3
Message-ID: <20020402172046.GA4129@troypc.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the following with 2.4.19-pre4-ac3 on boot and in dmesg. Was also
getting the message on stock 2.4.18 as well. The message told me to mail the
list so I'm just following instructions :-).

        testing the IO APIC.......................

        IO APIC #1......
        .... register #00: 01008000
        .......    : physical APIC id: 01
         WARNING: unexpected IO-APIC, please mail
                  to linux-smp@vger.kernel.org
        .... register #01: 00178020
        .......     : max redirection entries: 0017
        .......     : PRQ implemented: 1
        .......     : IO APIC version: 0020
        .... register #02: 00000000
        .......     : arbitration: 00

I know the message is coming from /linux/arch/i386/kernel/io_apic.c

        printk(KERN_DEBUG ".......    : physical APIC id: %02X\n",
reg_00.ID);
        if (reg_00.__reserved_1 || reg_00.__reserved_2)
                UNEXPECTED_IO_APIC();

reg_00.__reserved_1 is from struct IO_APIC_reg_00 defined in
/include/asm-i386/io_apic.h

Any ideas what the apic would return to cause this is coming up? I'm using
an i860 chipset with a dual Xeon.

Thanks,

Troy

