Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264608AbSIQVL4>; Tue, 17 Sep 2002 17:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264609AbSIQVL4>; Tue, 17 Sep 2002 17:11:56 -0400
Received: from pcow035o.blueyonder.co.uk ([195.188.53.121]:24847 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S264608AbSIQVLz>;
	Tue, 17 Sep 2002 17:11:55 -0400
Subject: Re: [Linux-usb-users] Re: Problems accessing USB Mass Storage
From: Mark C <gen-lists@blueyonder.co.uk>
To: linux-usb-users <linux-usb-users@lists.sourceforge.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3D878CF7.3040304@cypress.com>
References: <Pine.LNX.4.33L2.0209171119430.14033-100000@dragon.pdx.osdl.net>
	<3D878788.2030603@cypress.com> <20020917125817.B11583@one-eyed-alien.net> 
	<3D878CF7.3040304@cypress.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 17 Sep 2002 22:13:13 +0100
Message-Id: <1032297193.1276.23.camel@stimpy.angelnet.internal>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-17 at 21:13, Thomas Dodd wrote:

> 
> Give that a go Mark.
> 
> Try a few values like 25, 50, 75, and 100. with bs=1k and
> unset (default 512 byte).

If I'm reading this correctly, I have been trying:

[root@stimpy mark]# dd if=/dev/sda of=tmp/tmp.img skip=50 \
bs=1k                                                                                                         dd: reading `/dev/sda': Input/output error
0+0 records in
0+0 records out

Then the output of dmesg:

SCSI device (ioctl) reports ILLEGAL REQUEST.
SCSI device sda: 16384 512-byte hdwr sectors (8 MB)
sda: test WP failed, assume Write Enabled
 sda: I/O error: dev 08:00, sector 0
 I/O error: dev 08:00, sector 0
 unable to read partition table
 I/O error: dev 08:00, sector 96

I have altered skip from 25 - 100 and received the same errors, except
the sectors change in size with relation to altering the skip size.

This may be the wrong way of running the command, if so I'm sorry for
wasting peoples time on that.

Mark

-- 
---
To steal ideas from one person is plagiarism;
to steal from many is research.

