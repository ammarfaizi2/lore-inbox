Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271911AbRJJBEc>; Tue, 9 Oct 2001 21:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271978AbRJJBEX>; Tue, 9 Oct 2001 21:04:23 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:58095 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S271911AbRJJBEH>; Tue, 9 Oct 2001 21:04:07 -0400
Date: Wed, 10 Oct 2001 03:04:36 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Thomas Hood <jdthood@mail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.10-ac10
In-Reply-To: <1002666753.763.4.camel@thanatos>
Message-ID: <Pine.NEB.4.40.0110100249010.27027-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Oct 2001, Thomas Hood wrote:

>...
> 2) On the second boot ioport 0x530 is reported not to be free
>    and this prevents ad1816 from loading
>...
> 2) What is using 0x530?  What's in /proc/ioports?

# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0208-020f : PNP0c02
0213-0213 : isapnp read
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0530-053f : AD1816 Sound
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
5000-50ff : VIA Technologies, Inc. VT82C586B ACPI
d000-dfff : PCI Bus #01
e000-e00f : VIA Technologies, Inc. Bus Master IDE
  e000-e007 : ide0
  e008-e00f : ide1
e800-e81f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  e800-e81f : ne2k-pci
#



Two things that might perhaps have influence:

2.4.10-ac9
...
o       Clean up ad1816 resource handling       (Arnaldo Carvalho de Melo)
...


How does PnPBIOS work together with CONFIG_ISAPNP in the kernel?



cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400




