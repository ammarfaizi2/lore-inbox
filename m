Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264626AbSIQVgG>; Tue, 17 Sep 2002 17:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264627AbSIQVgF>; Tue, 17 Sep 2002 17:36:05 -0400
Received: from ns1.cypress.com ([157.95.67.4]:19111 "EHLO ns1.cypress.com")
	by vger.kernel.org with ESMTP id <S264626AbSIQVgE>;
	Tue, 17 Sep 2002 17:36:04 -0400
Message-ID: <3D87A152.50800@cypress.com>
Date: Tue, 17 Sep 2002 16:40:34 -0500
From: Thomas Dodd <ted@cypress.com>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark C <gen-lists@blueyonder.co.uk>
CC: linux-usb-users <linux-usb-users@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-usb-users] Re: Problems accessing USB Mass Storage
References: <Pine.LNX.4.33L2.0209171119430.14033-100000@dragon.pdx.osdl.net>	<3D878788.2030603@cypress.com> <20020917125817.B11583@one-eyed-alien.net> 	<3D878CF7.3040304@cypress.com> <1032297193.1276.23.camel@stimpy.angelnet.internal>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mark C wrote:
> [root@stimpy mark]# dd if=/dev/sda of=tmp/tmp.img skip=50 \
> bs=1k                                                                                                         dd: reading `/dev/sda': Input/output error

That's correct.

> Then the output of dmesg:
> 
> SCSI device (ioctl) reports ILLEGAL REQUEST.
> SCSI device sda: 16384 512-byte hdwr sectors (8 MB)
> sda: test WP failed, assume Write Enabled
>  sda: I/O error: dev 08:00, sector 0
>  I/O error: dev 08:00, sector 0
>  unable to read partition table
>  I/O error: dev 08:00, sector 96

That's what I expected. I didn't help.


Sector 96 is a little odd.  50 1K blocks
should be sector 99. (counting starts at zero)

I wonder why 96 is accessed...

This is really starting to look like it's
*NOT* really a Mass Storage Class device,
just claiming to be. (black list time?)

I noticed the windows driver setup several
other interfaces, like audio and VfW (video).

Best sugestion for now is buy 1) a memory card,
2) a card reader that works there are several.

It probably doesn't use the internal memory if a card
is loaded, but you'd have to read the manul/test to
find out. 8M isn't much room for pics at 1280x1024
any way :)


	-Thomas

