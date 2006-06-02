Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWFBJjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWFBJjD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 05:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWFBJjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 05:39:03 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:54189 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751368AbWFBJjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 05:39:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=phgwiTN2ViEAA9KcsC/4X2GFgpZZNt6CcliNgWPBNjRmGAfWjRv1k4MrX8JjFHamEu9bfc8RLhIZtYlpTQtjoyjdpgVf6D8cATSQ7RxGf11l0RXbui6+Ci87BgozpXaexXCkWaERVphaes+iGLrjjhZqR3mPa8QxY4bDlVs563M=
Message-ID: <79a6fb1e0606020239i49c38effxc688c12f94d5da41@mail.gmail.com>
Date: Fri, 2 Jun 2006 10:39:01 +0100
From: fonseka@gmail.com
To: linux-kernel@vger.kernel.org
Subject: BUG: scheduling while atomic
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi there!

recently I'm trying putting snmpd working on a old machine and ran into
problems... everytime i try to spawn the snmpd process I got a kernel
backtrace as follows, and the process never cames up:


Jun  2 10:02:55 apophis scheduling while atomic: snmpd/0x00000001/26757
Jun  2 10:02:55 apophis [<c035ea98>] schedule+0x5a8/0x6a0
Jun  2 10:02:55 apophis [<c035f4b1>] schedule_timeout+0x51/0xa0
Jun  2 10:02:55 apophis [<c0124a50>] process_timeout+0x0/0x10
Jun  2 10:02:55 apophis [<c0124cb8>] msleep+0x28/0x40
Jun  2 10:02:55 apophis [<c02867fc>] rhine_disable_linkmon+0x7c/0x140
Jun  2 10:02:55 apophis [<c0286705>] rhine_enable_linkmon+0x45/0xc0
Jun  2 10:02:55 apophis [<c02868ef>] mdio_read+0x2f/0xf0
Jun  2 10:02:55 apophis [<c021c042>] copy_to_user+0x42/0x60
Jun  2 10:02:55 apophis [<c028904d>] generic_mii_ioctl+0x11d/0x1c0
Jun  2 10:02:55 apophis [<c02880e0>] netdev_ioctl+0x0/0x70
Jun  2 10:02:55 apophis [<c0288127>] netdev_ioctl+0x47/0x70
Jun  2 10:02:55 apophis [<c02de19c>] dev_ifsioc+0x13c/0x440
Jun  2 10:02:55 apophis [<c02de6e4>] dev_ioctl+0x244/0x2b0
Jun  2 10:02:55 apophis [<c02d2ab4>] sock_ioctl+0x114/0x250
Jun  2 10:02:55 apophis [<c01743de>] do_ioctl+0x9e/0xb0
Jun  2 10:02:55 apophis [<c0174595>] vfs_ioctl+0x65/0x200
Jun  2 10:02:55 apophis [<c0174775>] sys_ioctl+0x45/0x70
Jun  2 10:02:55 apophis [<c01030cb>] sysenter_past_esp+0x54/0x75

I've tried with 2.6.15 and 2.6.16 with no sucess

using gcc 3.4.5
binutils 2.16.1
glibc 2.3.6

if you need any more info please just ask me

TIA

-- 
Will work for bandwidth
