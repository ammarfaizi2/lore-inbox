Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbTJNIMe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 04:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbTJNIMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 04:12:33 -0400
Received: from ns.suse.de ([195.135.220.2]:53995 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261979AbTJNIMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 04:12:31 -0400
Date: Tue, 14 Oct 2003 10:12:28 +0200
From: Olaf Hering <olh@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: gcc -msoft-float [Was: Linux 2.6.0-test7 - stability freeze]
Message-ID: <20031014081228.GA23257@suse.de>
References: <Pine.LNX.4.44.0310081235280.4017-100000@home.osdl.org> <20031013173446.GA13186@suse.de> <20031013205039.GA1638@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031013205039.GA1638@mars.ravnborg.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Oct 13, Sam Ravnborg wrote:

> On Mon, Oct 13, 2003 at 07:34:46PM +0200, Olaf Hering wrote:
> > a longstanding bug, should probably go to the main Makefile. But I dont
> > know if all supported archs know about -msoft-float.
> 
> Could you please elaborate about what this fixes.
> I'm very resistant to add new flags unconditionally to gcc at this stage.

Is floating point in the kernel really allowed on i386? If so, please
please add a commet to this Makefile about this fact. 

test7bk3 results, allyesconfig:


drivers/built-in.o(.text+0x2ba129): In function `amd8111e_resume':
drivers/net/amd8111e.c:1700: undefined reference to `__floatsidf'
drivers/built-in.o(.text+0x2ba145):drivers/net/amd8111e.c:1700: undefined reference to `__adddf3'
drivers/built-in.o(.text+0x2ba14d):drivers/net/amd8111e.c:1700: undefined reference to `__fixunsdfsi'
drivers/built-in.o(.text+0x2ba1c6):drivers/net/amd8111e.c:1702: undefined reference to `__adddf3'
drivers/built-in.o(.text+0x2ba2f0): In function `amd8111e_config_ipg':
drivers/net/amd8111e.c:1775: undefined reference to `__floatsidf'
drivers/built-in.o(.text+0x2ba308):drivers/net/amd8111e.c:1775: undefined reference to `__adddf3'
drivers/built-in.o(.text+0x2ba310):drivers/net/amd8111e.c:1775: undefined reference to `__fixunsdfsi'
drivers/built-in.o(.text+0x2ba343):drivers/net/amd8111e.c:1778: undefined reference to `__adddf3'
drivers/built-in.o(.text+0x2ba737): In function `amd8111e_probe_one':
drivers/net/amd8111e.c:1911: undefined reference to `__floatsidf'
drivers/built-in.o(.text+0x2ba753):drivers/net/amd8111e.c:1911: undefined reference to `__adddf3'
drivers/built-in.o(.text+0x2ba75b):drivers/net/amd8111e.c:1911: undefined reference to `__fixunsdfsi'
drivers/built-in.o(.text+0x2ba838):drivers/net/amd8111e.c:1940: undefined reference to `__adddf3'
drivers/built-in.o(.text+0x407fd7): In function `tuner_set_tv_freq':
drivers/media/dvb/ttpci/av7110.c:2709: undefined reference to `__floatsidf'
drivers/built-in.o(.text+0x407ff3):drivers/media/dvb/ttpci/av7110.c:2709: undefined reference to `__ltdf2'
drivers/built-in.o(.text+0x408001):drivers/media/dvb/ttpci/av7110.c:2711: undefined reference to `__floatsidf'
drivers/built-in.o(.text+0x408019):drivers/media/dvb/ttpci/av7110.c:2711: undefined reference to `__ltdf2'
drivers/built-in.o(.text+0x408060):drivers/media/dvb/ttpci/av7110.c:2720: undefined reference to `__adddf3'
drivers/built-in.o(.text+0x408076):drivers/media/dvb/ttpci/av7110.c:2720: undefined reference to `__adddf3'
drivers/built-in.o(.text+0x5c24d0): In function `sisfb_do_set_var':
drivers/video/sis/sis_main.c:654: undefined reference to `__floatsidf'
drivers/built-in.o(.text+0x5c24ec):drivers/video/sis/sis_main.c:654: undefined reference to `__divdf3'
drivers/built-in.o(.text+0x5c24f7):drivers/video/sis/sis_main.c:655: undefined reference to `__floatsidf'
drivers/built-in.o(.text+0x5c2510):drivers/video/sis/sis_main.c:655: undefined reference to `__divdf3'
drivers/built-in.o(.text+0x5c251b):drivers/video/sis/sis_main.c:656: undefined reference to `__floatsidf'
drivers/built-in.o(.text+0x5c2534):drivers/video/sis/sis_main.c:656: undefined reference to `__divdf3'
drivers/built-in.o(.text+0x5c2540):drivers/video/sis/sis_main.c:656: undefined reference to `__adddf3'
drivers/built-in.o(.text+0x5c2554):drivers/video/sis/sis_main.c:656: undefined reference to `__adddf3'
drivers/built-in.o(.text+0x5c255c):drivers/video/sis/sis_main.c:656: undefined reference to `__fixunsdfsi'
drivers/built-in.o(.text+0x5c28b8):drivers/video/sis/sis_main.c:675: undefined reference to `__adddf3'
drivers/built-in.o(.text+0x5c28d1):drivers/video/sis/sis_main.c:675: undefined reference to `__adddf3'
drivers/built-in.o(.text+0x5c28ea):drivers/video/sis/sis_main.c:675: undefined reference to `__adddf3'
drivers/built-in.o(.init.text+0x6252d): In function `sisfb_init':
drivers/video/sis/sis_main.c:4450: undefined reference to `__floatsidf'
drivers/built-in.o(.init.text+0x6253f):drivers/video/sis/sis_main.c:4450: undefined reference to `__divdf3'
drivers/built-in.o(.init.text+0x62547):drivers/video/sis/sis_main.c:4450: undefined reference to `__fixunsdfsi'


thanks.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
