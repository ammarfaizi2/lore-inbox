Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVECHbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVECHbK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 03:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVECHbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 03:31:10 -0400
Received: from 213-229-38-66.static.adsl-line.inode.at ([213.229.38.66]:35460
	"HELO mail.falke.at") by vger.kernel.org with SMTP id S261418AbVECHbD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 03:31:03 -0400
Message-ID: <4277287E.4040003@winischhofer.net>
Date: Tue, 03 May 2005 09:30:06 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, ak@muc.de, hch@lst.de,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] {,un}register_ioctl32_conversion should have been
 removed last month
References: <20050502014550.GG3592@stusta.de> <20050502173052.5c78ae30.akpm@osdl.org> <20050503003959.GQ3592@stusta.de>
In-Reply-To: <20050503003959.GQ3592@stusta.de>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Adrian Bunk wrote:
> On Mon, May 02, 2005 at 05:30:52PM -0700, Andrew Morton wrote:
> 
>>Adrian Bunk <bunk@stusta.de> wrote:
>>
>>>This removal should have happened last month.
>>
>>drivers/usb/misc/sisusbvga/sisusb.c will use these functions if someone
>>defines SISUSB_OLD_CONFIG_COMPAT, so we need to agree to zap that code
>>before I can merge this upstream.


Why on earth should anyone #define something with "SISUSB" in the
beginning, on a level that might be available in a usb driver?


> 
> That's not a problem.
> 
> 
> Quoting drivers/usb/misc/sisusbvga/sisusb.h:
> 
> #ifdef CONFIG_COMPAT
> #if LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,10)
> #include <linux/ioctl32.h>
> #define SISUSB_OLD_CONFIG_COMPAT
> #else
> #define SISUSB_NEW_CONFIG_COMPAT
> #endif
> #endif
> 
> 
> I decided not to drop the SISUSB_OLD_CONFIG_COMPAT code in my patch 
> because it seems Thomas is sharing this code between different kernel 
> versions, and a removal might make his life harder for no big win.


Exactly. Thanks, Adrian.

Thomas

- --
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net	       *** http://www.winischhofer.net
twini AT xfree86 DOT org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCdyh+zydIRAktyUcRAgTLAKDJ7woebRDkqRS70aImI5c0y+fiyQCgyNqE
8haWeqvcbbbCjYn607Xh51E=
=ZaoZ
-----END PGP SIGNATURE-----
