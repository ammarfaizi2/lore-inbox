Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277797AbRJOQTp>; Mon, 15 Oct 2001 12:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277790AbRJOQTf>; Mon, 15 Oct 2001 12:19:35 -0400
Received: from dfw-smtpout4.email.verio.net ([129.250.36.44]:64937 "EHLO
	dfw-smtpout4.email.verio.net") by vger.kernel.org with ESMTP
	id <S277656AbRJOQTY>; Mon, 15 Oct 2001 12:19:24 -0400
Message-ID: <3BCB0CA7.46203D3F@bigfoot.com>
Date: Mon, 15 Oct 2001 09:19:51 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20p10i i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Cyrus <cyrusone@ihug.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Large Storage Devices in Linux.....Kernel level support.....
In-Reply-To: <3BC93DCB.20400@linuxmail.org> <3BCAC80F.9050705@ihug.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > i've got a setup of 2 hard drives (30GB & 40GB) with an Asus a7m266 mobo
>  > with a VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06).
>  >
>  > 30GB= fujitsu, 40GB= IBM (both are 7200rpm
>  >
>  > i've got my cdrw on /dev/hdc, 30GB=/dev/hda, and 40GB=/dev/hdb...

You also want to move the IBM to IDE1 to avoid 1/2 speed throttle
situations.  Don't forget to update /dev/fstab and the /dev/cdrom and/or
/dev/cdr links before you reboot.

Current
-------
IDE0/M	/dev/hda	30GB
IDE0/S	/dev/hdb	40GB
IDE1/M	/dev/hdc	CD-RW

Better disk I/O
---------------
IDE0/M	/dev/hda	30GB
IDE1/M	/dev/hdc	40GB
IDE1/S	/dev/hdd	CD-RW

	or

IDE0/M	/dev/hda	30GB
IDE0/S	/dev/hdd	CD-RW
IDE1/M	/dev/hdc	40GB


rgds,
tim.
--
