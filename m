Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286397AbRLTVaU>; Thu, 20 Dec 2001 16:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286394AbRLTVaI>; Thu, 20 Dec 2001 16:30:08 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:1512
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S286393AbRLTV3w>; Thu, 20 Dec 2001 16:29:52 -0500
Date: Thu, 20 Dec 2001 22:29:43 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.17-rc2
Message-ID: <20011220222943.D2081@jaquet.dk>
In-Reply-To: <Pine.LNX.4.21.0112181824020.4821-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0112181824020.4821-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Dec 18, 2001 at 06:26:03PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2001 at 06:26:03PM -0200, Marcelo Tosatti wrote:
> 
> Hi,
> 
> So here it goes 2.4.17-rc2... as expected, bugfixes only.

Hi.

I get the following error during kernel linking when compiling 
with CONFIG_SERIAL=m and CONFIG_SERIAL_ACPI=y (at least, thats
my guess. .config snippet below).

drivers/char/char.o: In function `setup_serial_acpi':
drivers/char/char.o(.text.init+0x10fb): undefined reference to `early_serial_setup'
gmake: *** [vmlinux] Error 1


I would provide a patch but can't :)


#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
CONFIG_SERIAL_ACPI=y
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_MANY_PORTS=y
CONFIG_SERIAL_SHARE_IRQ=y
CONFIG_SERIAL_DETECT_IRQ=y
CONFIG_SERIAL_MULTIPORT=y
CONFIG_HUB6=y
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_COMPUTONE=m

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)
