Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265789AbUGJQT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265789AbUGJQT4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 12:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266025AbUGJQTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 12:19:55 -0400
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:4250 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S265789AbUGJQTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 12:19:53 -0400
Date: Sat, 10 Jul 2004 10:20:26 -0600
From: "Eric D. Mudama" <edmudama@bounceswoosh.org>
To: Ed Tomlinson <edt@aei.ca>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.7-mm7 ide errors
Message-ID: <20040710162026.GA12371@bounceswoosh.org>
Mail-Followup-To: Ed Tomlinson <edt@aei.ca>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>
References: <200407100848.15665.edt@aei.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <200407100848.15665.edt@aei.ca>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10 at  8:48, Ed Tomlinson wrote:
>Hi,
>
>The ide error introduced with the barrier patches are still happening here with mm7. 
>
>Jul 10 08:06:04 bert usb.agent[1705]:      usbhid: loaded successfully
>Jul 10 08:06:04 bert input.agent[1738]:      joydev: loaded successfully
>Jul 10 08:06:06 bert kernel: lp: driver loaded but no devices found
>Jul 10 08:06:16 bert kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
>Jul 10 08:06:16 bert kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
>Jul 10 08:06:16 bert kernel: ide: failed opcode was: 0xe7
>Jul 10 08:06:18 bert kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
>Jul 10 08:06:18 bert kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
>Jul 10 08:06:18 bert kernel: ide: failed opcode was: 0xe7
>
>Typically  I get one of the above every couple of minutes and have since the barrier changes
>when into mm.
>
>What can I do to help get to the bottom of this problem?

0xE7 is the 'FLUSH CACHE' command for use on drives <= 137GB.

What model of drive do you have, and how big is it?


-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

