Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269313AbRHCFPj>; Fri, 3 Aug 2001 01:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269315AbRHCFPa>; Fri, 3 Aug 2001 01:15:30 -0400
Received: from radiuslog.rad.net.id ([202.154.1.12]:52431 "EHLO
	smtp.rad.net.id") by vger.kernel.org with ESMTP id <S269313AbRHCFPV>;
	Fri, 3 Aug 2001 01:15:21 -0400
Message-ID: <3B6A2B9A.6E88D0E8@theOffice.net>
Date: Fri, 03 Aug 2001 11:42:02 +0700
From: Agus Budy Wuysang <supes@theOffice.net>
Organization: PT Fajar Surya Wisesa Tbk
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-xfs i686)
X-Accept-Language: id, en
MIME-Version: 1.0
To: "Paul G. Allen" <pgallen@randomlogic.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dual Athlon, AGP, and PCI
In-Reply-To: <3B691B85.368D1BD0@randomlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul G. Allen" wrote:
> 
> The NVidia driver, as advertised, will use its own AGP driver, Jeff's
> agpgart driver, or fall back to PCI mode. According to NVidia, you can
> enable the different modes by setting NVagp in XF86Config-4 to a number.
> I set it to use agpgart. Here's the rub.

My mainboard is Abit KT7A, when I was using kernel 2.2.x
I could use NV internal AGP support, after upgrading
kernel to 2.4.x I have to use AGPGART, otherwise it will
fall back to PCI mode.

> Using the same software I used to generate the Kernel source
> documentation on my web server, I took a look at the NVidia driver. I
> found a lot of useful DEBUG code and I found some conditional code that
> allows the NVidia driver to use agpgart. Neither code section was being
> compiled either by the Makefile or the RPM .spec file. So, I modified
> the Makefile for NVdriver (-DDEBUG and -DAGPGART), compiled and
> installed NVdriver, and restarted X. Black screen and Ctrl+Alt+Del.

You don't need to to do this, it is in NVdia README

Option "NvAGP" "integer"
 Configure AGP support. Integer argument can be one of:
0 : disable agp
1 : use NVIDIA's internal AGP support, if possible 
2 : use AGPGART, if possible 
3 : use any agp support (try AGPGART, then NVIDIA's AGP) 
Default: 1.

There are other options you can use.
see Appendix D NVGLX readme.

Oh well binary drivers sux, but better than setting aside
another partition just for running Quake3 under Window$ :)

-- 
+-R-| Netscape Communicator 4.x |-H-| Powered by Linux 2.4.x |-7-+
|/v\ Agus Budy Wuysang                   MIS Department          |
| |  Phone:  +62-21-344-1316 ext 317     GSM: +62-816-1972-051   |
+--------| http://www.rad.net.id/users/personal/s/supes |--------+
