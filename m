Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272758AbTG1JXa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 05:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272750AbTG1JX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 05:23:29 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:30468 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S272758AbTG1JXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 05:23:25 -0400
Date: Mon, 28 Jul 2003 06:41:33 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6] serial port broken? [fixed]
Message-Id: <20030728064133.67b04a52.vmlinuz386@yahoo.com.ar>
In-Reply-To: <20030728051307.0f714062.vmlinuz386@yahoo.com.ar>
References: <20030728051307.0f714062.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003 05:13:07 -0300, Gerardo Exequiel Pozzi wrote:
>Hi,
>
>I have a serial mouse, that works ok with 2.4, but in 2.6.0-test[12]
>don't work.
>
>The kernel does not recognize the serial port.
>
>root@djgera:~# cat /dev/ttyS0
>cat: /dev/ttyS0: No such device
>
>I am sure that the configuration options that use are well, considering
>like main to these:
>
>CONFIG_INPUT_MOUSEDEV=y
>CONFIG_INPUT_MOUSE=y
>CONFIG_MOUSE_SERIAL=y
>CONFIG_SERIO=y
>CONFIG_SERIO_I8042=y
>CONFIG_SERIO_SERPORT=y
>CONFIG_INPUT_KEYBOARD=y
>CONFIG_KEYBOARD_ATKBD=y
>CONFIG_INPUT_MISC=y
>CONFIG_INPUT_PCSPKR=y
>


sorry! i don'n have the option CONFIG_SERIAL_8250, now works perfectly.
the dmesg:

Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A

Sorry! and sorry!


>Apparently kernel recognizes both serial ports, look this
>in this port i have connected mouse. ttyS0
>
>root@djgera:~# cat /sys/bus/pnp/devices/00\:0a/*
>PNP0501
>16550A-compatible COM port
>irq 3,4,5,7 High-Edge
>Dependent: 01 - Priority acceptable
>   port 0x3f8-0x3f8, align 0x0, size 0x8, 16-bit address decoding
>Dependent: 02 - Priority acceptable
>   port 0x2f8-0x2f8, align 0x0, size 0x8, 16-bit address decoding
>Dependent: 03 - Priority acceptable
>   port 0x3e8-0x3e8, align 0x0, size 0x8, 16-bit address decoding
>Dependent: 04 - Priority acceptable
>   port 0x2e8-0x2e8, align 0x0, size 0x8, 16-bit address decoding
>0
>state = active
>io 0x3f8-0x3ff
>irq 4
>
>root@djgera:~# cat /proc/bus/input/devices
>I: Bus=0010 Vendor=001f Product=0001 Version=0100
>N: Name="PC Speaker"
>P: Phys=isa0061/input0
>H: Handlers=kbd
>B: EV=40001
>B: SND=6
>
>I: Bus=0011 Vendor=0001 Product=0002 Version=ab02
>N: Name="AT Set 2 keyboard"
>P: Phys=isa0060/serio0/input0
>H: Handlers=kbd
>B: EV=120003
>B: KEY=4 2000000 c061f9 fbc9d621 efdfffdf ffefffff ffffffff fffffffe
>B: LED=7
>
>
>no mouse information here.
>what is wrong?
>
>Oh! also activate DEBUG in drivers/input/serio/i8042.c and no debug
>messages appears when moving mouse.
>
>
>Thanks in Advance.
>
>attached the dmesg and config.
>
>

chau, djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
