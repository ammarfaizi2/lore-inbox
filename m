Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290958AbSBVBgD>; Thu, 21 Feb 2002 20:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290965AbSBVBfx>; Thu, 21 Feb 2002 20:35:53 -0500
Received: from mail.myrio.com ([63.109.146.2]:38905 "HELO mail.myrio.com")
	by vger.kernel.org with SMTP id <S290958AbSBVBff> convert rfc822-to-8bit;
	Thu, 21 Feb 2002 20:35:35 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: boot messeage
Date: Thu, 21 Feb 2002 17:34:00 -0800
Message-ID: <A015F722AB845E4B8458CBABDFFE63420D730A@mail0.myrio.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: boot messeage
Thread-Index: AcG7QBG1MmBelJuPRhe+tmQG/b3avgAAHj3g
From: "Torrey Hoffman" <Torrey.Hoffman@myrio.com>
To: "Pozsar Balazs" <pozsy@sch.bme.hu>,
        "hanhbkernel" <hanhbkernel@yahoo.com.cn>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Feb 2002 01:34:55.0201 (UTC) FILETIME=[217A3510:01C1BB41]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 22 Feb 2002, [gb2312] hanhbkernel wrote:
> 
> > When booting Linux, the kernel messages are shown on
> > screen.
> > I don't like to show these messages, so  "Support for

[...]

Or, you can put the console on the second tty, and then you will not see the
messages unless you want to. 

Compile in support for console on virtual terminal, and also VGA text console
or one of the framebuffer consoles.

Then use append="console=/dev/tty2 CONSOLE=/dev/tty2", and you won't
see anything on the boot screen except the linux logo (if you choose a 
framebuffer console).  But, you can type "Alt-F2" to bring up the second 
console with the boot messages on it.  This is useful when things go wrong.

If you want a prettier boot logo, check out www.arnor.net/linuxlogo for some
patches that let you build in any logo you want at kernel compile time.

Torrey Hoffman

