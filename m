Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314680AbSHXBHa>; Fri, 23 Aug 2002 21:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314938AbSHXBHa>; Fri, 23 Aug 2002 21:07:30 -0400
Received: from firewall2.uwindsor.ca ([137.207.233.22]:43745 "HELO
	internet2.uwindsor.ca") by vger.kernel.org with SMTP
	id <S314680AbSHXBH1> convert rfc822-to-8bit; Fri, 23 Aug 2002 21:07:27 -0400
Content-Type: text/plain;
  charset="iso-8859-15"
From: Martin =?iso-8859-15?q?K=F6bele?= <martin@mkoebele.de>
To: linux-kernel@vger.kernel.org
Subject: BUG, 8250.c doesn't compile in 2.5.31
Date: Fri, 23 Aug 2002 21:06:08 -0400
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200208232106.08048.martin@mkoebele.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, couldn't find a bug report in the archive.
I tried to compile the kernel with serial 8250 support (Character Devices-> 
Serial Drivers..)


I got this message:

gcc -Wp,-MD,./.8250.o.d -D__KERNEL__ -I/usr/src/linux-2.5.31/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -malign-functions=4  -nostdinc -iwithprefix include -DMODULE 
-include /usr/src/linux-2.5.31/include/linux/modversions.h   
-DKBUILD_BASENAME=8250 -DEXPORT_SYMTAB  -c -o 8250.o 8250.c
In file included from 8250.c:34:
/usr/src/linux-2.5.31/include/linux/serialP.h:50: field `icount' has 
incomplete type
8250.c:106: `ASYNC_BOOT_AUTOCONF' undeclared here (not in a function)
8250.c:106: `ASYNC_SKIP_TEST' undeclared here (not in a function)
8250.c:106: initializer element is not constant
8250.c:106: (near initialization for `old_serial_port[0].flags')
8250.c:106: `ASYNC_BOOT_AUTOCONF' undeclared here (not in a function)
8250.c:106: `ASYNC_SKIP_TEST' undeclared here (not in a function)
8250.c:106: initializer element is not constant
8250.c:106: (near initialization for `old_serial_port[1].flags')
8250.c:106: `ASYNC_BOOT_AUTOCONF' undeclared here (not in a function)
8250.c:106: `ASYNC_SKIP_TEST' undeclared here (not in a function)
8250.c:106: initializer element is not constant
8250.c:106: (near initialization for `old_serial_port[2].flags')
8250.c:106: `ASYNC_BOOT_AUTOCONF' undeclared here (not in a function)
8250.c:106: initializer element is not constant
8250.c:106: (near initialization for `old_serial_port[3].flags')
8250.c:106: `ASYNC_FOURPORT' undeclared here (not in a function)
8250.c:106: initializer element is not constant
8250.c:106: (near initialization for `old_serial_port[4].flags')
8250.c:106: `ASYNC_FOURPORT' undeclared here (not in a function)
8250.c:106: initializer element is not constant
8250.c:106: (near initialization for `old_serial_port[5].flags')
8250.c:106: `ASYNC_FOURPORT' undeclared here (not in a function)
8250.c:106: initializer element is not constant
8250.c:106: (near initialization for `old_serial_port[6].flags')
8250.c:106: `ASYNC_FOURPORT' undeclared here (not in a function)
8250.c:106: initializer element is not constant
8250.c:106: (near initialization for `old_serial_port[7].flags')
8250.c:106: `ASYNC_FOURPORT' undeclared here (not in a function)
8250.c:106: initializer element is not constant
8250.c:106: (near initialization for `old_serial_port[8].flags')
8250.c:106: `ASYNC_FOURPORT' undeclared here (not in a function)
8250.c:106: initializer element is not constant
8250.c:106: (near initialization for `old_serial_port[9].flags')
8250.c:106: `ASYNC_FOURPORT' undeclared here (not in a function)
8250.c:106: initializer element is not constant
8250.c:106: (near initialization for `old_serial_port[10].flags')
8250.c:106: `ASYNC_FOURPORT' undeclared here (not in a function)
8250.c:106: initializer element is not constant
8250.c:106: (near initialization for `old_serial_port[11].flags')
8250.c:145: elements of array `uart_config' have incomplete type
8250.c:146: warning: excess elements in struct initializer
8250.c:146: warning: (near initialization for `uart_config[0]')
8250.c:146: warning: excess elements in struct initializer
8250.c:146: warning: (near initialization for `uart_config[0]')
8250.c:146: warning: excess elements in struct initializer
8250.c:146: warning: (near initialization for `uart_config[0]')
8250.c:147: warning: excess elements in struct initializer
8250.c:147: warning: (near initialization for `uart_config[1]')
8250.c:147: warning: excess elements in struct initializer
8250.c:147: warning: (near initialization for `uart_config[1]')
8250.c:147: warning: excess elements in struct initializer
8250.c:147: warning: (near initialization for `uart_config[1]')
8250.c:148: warning: excess elements in struct initializer
8250.c:148: warning: (near initialization for `uart_config[2]')
8250.c:148: warning: excess elements in struct initializer
8250.c:148: warning: (near initialization for `uart_config[2]')
8250.c:148: warning: excess elements in struct initializer
8250.c:148: warning: (near initialization for `uart_config[2]')
8250.c:149: warning: excess elements in struct initializer
8250.c:149: warning: (near initialization for `uart_config[3]')
8250.c:149: warning: excess elements in struct initializer
8250.c:149: warning: (near initialization for `uart_config[3]')
8250.c:149: warning: excess elements in struct initializer
8250.c:149: warning: (near initialization for `uart_config[3]')
8250.c:150: warning: excess elements in struct initializer
8250.c:150: warning: (near initialization for `uart_config[4]')
8250.c:150: warning: excess elements in struct initializer
8250.c:150: warning: (near initialization for `uart_config[4]')
8250.c:150: `UART_CLEAR_FIFO' undeclared here (not in a function)
8250.c:150: `UART_USE_FIFO' undeclared here (not in a function)
8250.c:150: warning: excess elements in struct initializer
8250.c:150: warning: (near initialization for `uart_config[4]')
8250.c:151: warning: excess elements in struct initializer
8250.c:151: warning: (near initialization for `uart_config[5]')
8250.c:151: warning: excess elements in struct initializer
8250.c:151: warning: (near initialization for `uart_config[5]')
8250.c:151: warning: excess elements in struct initializer
8250.c:151: warning: (near initialization for `uart_config[5]')
8250.c:152: warning: excess elements in struct initializer
8250.c:152: warning: (near initialization for `uart_config[6]')
8250.c:152: warning: excess elements in struct initializer
8250.c:152: warning: (near initialization for `uart_config[6]')
8250.c:152: `UART_CLEAR_FIFO' undeclared here (not in a function)
8250.c:152: `UART_STARTECH' undeclared here (not in a function)
8250.c:152: warning: excess elements in struct initializer
8250.c:152: warning: (near initialization for `uart_config[6]')
8250.c:153: warning: excess elements in struct initializer
8250.c:153: warning: (near initialization for `uart_config[7]')
8250.c:153: warning: excess elements in struct initializer
8250.c:153: warning: (near initialization for `uart_config[7]')
8250.c:153: `UART_CLEAR_FIFO' undeclared here (not in a function)
8250.c:153: `UART_USE_FIFO' undeclared here (not in a function)
8250.c:153: `UART_STARTECH' undeclared here (not in a function)
8250.c:153: warning: excess elements in struct initializer
8250.c:153: warning: (near initialization for `uart_config[7]')
8250.c:154: warning: excess elements in struct initializer
8250.c:154: warning: (near initialization for `uart_config[8]')
8250.c:154: warning: excess elements in struct initializer
8250.c:154: warning: (near initialization for `uart_config[8]')
8250.c:154: `UART_CLEAR_FIFO' undeclared here (not in a function)
8250.c:154: `UART_USE_FIFO' undeclared here (not in a function)
8250.c:154: warning: excess elements in struct initializer
8250.c:154: warning: (near initialization for `uart_config[8]')
8250.c:155: warning: excess elements in struct initializer
8250.c:155: warning: (near initialization for `uart_config[9]')
8250.c:155: warning: excess elements in struct initializer
8250.c:155: warning: (near initialization for `uart_config[9]')
8250.c:155: warning: excess elements in struct initializer
8250.c:155: warning: (near initialization for `uart_config[9]')
8250.c:156: warning: excess elements in struct initializer
8250.c:156: warning: (near initialization for `uart_config[10]')
8250.c:156: warning: excess elements in struct initializer
8250.c:156: warning: (near initialization for `uart_config[10]')
8250.c:156: `UART_CLEAR_FIFO' undeclared here (not in a function)
8250.c:156: `UART_USE_FIFO' undeclared here (not in a function)
8250.c:156: warning: excess elements in struct initializer
8250.c:156: warning: (near initialization for `uart_config[10]')
8250.c:157: warning: excess elements in struct initializer
8250.c:157: warning: (near initialization for `uart_config[11]')
8250.c:157: warning: excess elements in struct initializer
8250.c:157: warning: (near initialization for `uart_config[11]')
8250.c:157: `UART_CLEAR_FIFO' undeclared here (not in a function)
8250.c:157: `UART_USE_FIFO' undeclared here (not in a function)
8250.c:157: `UART_STARTECH' undeclared here (not in a function)
8250.c:157: warning: excess elements in struct initializer
8250.c:157: warning: (near initialization for `uart_config[11]')
8250.c:158: warning: excess elements in struct initializer
8250.c:158: warning: (near initialization for `uart_config[12]')
8250.c:158: warning: excess elements in struct initializer
8250.c:158: warning: (near initialization for `uart_config[12]')
8250.c:158: `UART_CLEAR_FIFO' undeclared here (not in a function)
8250.c:158: `UART_USE_FIFO' undeclared here (not in a function)
8250.c:158: `UART_STARTECH' undeclared here (not in a function)
8250.c:158: warning: excess elements in struct initializer
8250.c:158: warning: (near initialization for `uart_config[12]')
8250.c:159: warning: excess elements in struct initializer
8250.c:159: warning: (near initialization for `uart_config[13]')
8250.c:159: warning: excess elements in struct initializer
8250.c:159: warning: (near initialization for `uart_config[13]')
8250.c:159: `UART_CLEAR_FIFO' undeclared here (not in a function)
8250.c:159: `UART_USE_FIFO' undeclared here (not in a function)
8250.c:159: warning: excess elements in struct initializer
8250.c:159: warning: (near initialization for `uart_config[13]')
8250.c:160: invalid use of undefined type `struct serial_uart_config'
8250.c: In function `serial_in':
8250.c:167: `SERIAL_IO_HUB6' undeclared (first use in this function)
8250.c:167: (Each undeclared identifier is reported only once
8250.c:167: for each function it appears in.)
8250.c:171: `SERIAL_IO_MEM' undeclared (first use in this function)
8250.c:168: warning: unreachable code at beginning of switch statement
8250.c: In function `serial_out':
8250.c:185: `SERIAL_IO_HUB6' undeclared (first use in this function)
8250.c:190: `SERIAL_IO_MEM' undeclared (first use in this function)
8250.c:186: warning: unreachable code at beginning of switch statement
8250.c: In function `autoconfig':
8250.c:457: `ASYNC_BUGGY_UART' undeclared (first use in this function)
8250.c:503: `ASYNC_SKIP_TEST' undeclared (first use in this function)
8250.c:600: invalid use of undefined type `struct serial_uart_config'
8250.c: In function `autoconfig_irq':
8250.c:640: `ASYNC_FOURPORT' undeclared (first use in this function)
8250.c: In function `serial8250_startup':
8250.c:1121: invalid use of undefined type `struct serial_uart_config'
8250.c:1121: `UART_CLEAR_FIFO' undeclared (first use in this function)
8250.c:1141: `ASYNC_BUGGY_UART' undeclared (first use in this function)
8250.c:1171: `ASYNC_FOURPORT' undeclared (first use in this function)
8250.c: In function `serial8250_shutdown':
8250.c:1225: `ASYNC_FOURPORT' undeclared (first use in this function)
8250.c: In function `serial8250_change_speed':
8250.c:1307: invalid use of undefined type `struct serial_uart_config'
8250.c:1307: `UART_USE_FIFO' undeclared (first use in this function)
8250.c:1363: invalid use of undefined type `struct serial_uart_config'
8250.c:1363: `UART_STARTECH' undeclared (first use in this function)
8250.c: In function `serial8250_pm':
8250.c:1391: invalid use of undefined type `struct serial_uart_config'
8250.c:1391: `UART_STARTECH' undeclared (first use in this function)
8250.c:1410: invalid use of undefined type `struct serial_uart_config'
8250.c: In function `serial8250_request_std_resource':
8250.c:1467: `SERIAL_IO_MEM' undeclared (first use in this function)
8250.c:1475: `SERIAL_IO_HUB6' undeclared (first use in this function)
8250.c:1476: `SERIAL_IO_PORT' undeclared (first use in this function)
8250.c:1468: warning: unreachable code at beginning of switch statement
8250.c: In function `serial8250_request_rsa_resource':
8250.c:1493: `SERIAL_IO_MEM' undeclared (first use in this function)
8250.c:1503: `SERIAL_IO_HUB6' undeclared (first use in this function)
8250.c:1504: `SERIAL_IO_PORT' undeclared (first use in this function)
8250.c:1494: warning: unreachable code at beginning of switch statement
8250.c: In function `serial8250_release_port':
8250.c:1529: `SERIAL_IO_MEM' undeclared (first use in this function)
8250.c:1545: `SERIAL_IO_HUB6' undeclared (first use in this function)
8250.c:1546: `SERIAL_IO_PORT' undeclared (first use in this function)
8250.c:1530: warning: unreachable code at beginning of switch statement
8250.c: In function `serial8250_request_port':
8250.c:1576: `SERIAL_IO_MEM' undeclared (first use in this function)
8250.c: In function `serial8250_verify_port':
8250.c:1639: dereferencing pointer to incomplete type
8250.c:1639: dereferencing pointer to incomplete type
8250.c:1640: dereferencing pointer to incomplete type
8250.c:1640: dereferencing pointer to incomplete type
8250.c:1641: dereferencing pointer to incomplete type
8250.c:1641: dereferencing pointer to incomplete type
8250.c:1642: dereferencing pointer to incomplete type
8250.c: In function `serial8250_type':
8250.c:1652: sizeof applied to an incomplete type
8250.c:1652: invalid use of undefined type `struct serial_uart_config'
8250.c:1654: invalid use of undefined type `struct serial_uart_config'
8250.c:1655: warning: control reaches end of non-void function
8250.c: In function `__register_serial':
8250.c:1865: dereferencing pointer to incomplete type
8250.c:1866: dereferencing pointer to incomplete type
8250.c:1867: dereferencing pointer to incomplete type
8250.c:1868: dereferencing pointer to incomplete type
8250.c:1869: dereferencing pointer to incomplete type
8250.c:1870: dereferencing pointer to incomplete type
8250.c:1871: dereferencing pointer to incomplete type
8250.c:1872: dereferencing pointer to incomplete type
8250.c:1872: `ASYNC_BOOT_AUTOCONF' undeclared (first use in this function)
8250.c:1876: dereferencing pointer to incomplete type
8250.c: In function `early_serial_setup':
8250.c:1908: dereferencing pointer to incomplete type
make[2]: *** [8250.o] Fehler 1
make[2]: Verlassen des Verzeichnisses Verzeichnis 
»/usr/src/linux-2.5.31/drivers/serial«
make[1]: *** [serial] Fehler 2
make[1]: Verlassen des Verzeichnisses Verzeichnis 
»/usr/src/linux-2.5.31/drivers«
make: *** [drivers] Fehler 2

Martin Koebele
