Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293235AbSBWWfd>; Sat, 23 Feb 2002 17:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293236AbSBWWfY>; Sat, 23 Feb 2002 17:35:24 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:7667
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293235AbSBWWfJ>; Sat, 23 Feb 2002 17:35:09 -0500
Date: Sat, 23 Feb 2002 14:35:46 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18-rc2-ac2
Message-ID: <20020223223546.GN20060@matchmail.com>
Mail-Followup-To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200202212020.g1LKK2209402@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200202212020.g1LKK2209402@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2002 at 03:20:02PM -0500, Alan Cox wrote:
> [+ indicates stuff that went to Marcelo, o stuff that has not,
>  * indicates stuff that is merged in mainstream now, X stuff that proved
>    bad and was dropped out]
> 
> Linux 2.4.18rc2-ac2
> o	Add an SC520 watchdog, and enable wd8387ff 	(Scott Jennings)

It's not compiling:

w83877f_wdt.c: In function fop_open':
w83877f_wdt.c:217: incompatible type for argument 1 of spin_lock'
w83877f_wdt.c:219: incompatible type for argument 1 of spin_unlock'
w83877f_wdt.c:224: incompatible type for argument 1 of spin_unlock'
make[2]: *** [w83877f_wdt.o] Error 1
make[2]: Leaving directory /home/usr/src/lk2.4/2.4.18-rc2-ac2/drivers/char'
make[1]: *** [_modsubdir_char] Error 2
make[1]: Leaving directory /home/usr/src/lk2.4/2.4.18-rc2-ac2/drivers'
make: *** [_mod_drivers] Error 2

This change to my .config makes my config compile:

--- ../.config	Sat Feb 23 13:24:27 2002
+++ .config	Sat Feb 23 14:13:36 2002
@@ -875,7 +875,7 @@
 CONFIG_I810_TCO=m
 CONFIG_MIXCOMWD=m
 CONFIG_60XX_WDT=m
-CONFIG_W83877F_WDT=m
+# CONFIG_W83877F_WDT is not set
 CONFIG_SC520_WDT=m
 CONFIG_MACHZ_WDT=m
 CONFIG_AMD_RNG=m


Mike
