Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273697AbRIQVWq>; Mon, 17 Sep 2001 17:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273698AbRIQVWh>; Mon, 17 Sep 2001 17:22:37 -0400
Received: from mail.missioncriticallinux.com ([208.51.139.18]:5648 "EHLO
	missioncriticallinux.com") by vger.kernel.org with ESMTP
	id <S273697AbRIQVW1>; Mon, 17 Sep 2001 17:22:27 -0400
Message-ID: <3BA669A8.812D381D@MissionCriticalLinux.com>
Date: Mon, 17 Sep 2001 14:22:48 -0700
From: Bruce Blinn <blinn@MissionCriticalLinux.com>
Organization: Mission Critical Linux
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.6-bcb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Masoud Sharbiani <masu@cr213096-a.rchrd1.on.wave.home.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Reading Windows CD on Linux 2.4.6
In-Reply-To: <Pine.LNX.3.95.1010917155338.17362A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Mon, 17 Sep 2001, Bruce Blinn wrote:
> [SNIPPED...]
> 
> Just do `cp /dev/cdrom /tmp/foo`. ^C out when you think you have
> enough, then use `dd` to copy a small portion of the image file.
> 

Here are the results of the methods that were suggested for producing a
CD image.  They all seem to fail at the same place because the resulting
file is the same size.

	# dd if=/dev/cdrom of=/tmp/cd1.iso
	dd: /dev/cdrom: Input/output error
	1440+0 records in
	1440+0 records out
 
	# dd if=/dev/cdrom of=/tmp/cd2.iso bs=2k
	dd: /dev/cdrom: Input/output error
	360+0 records in
	360+0 records out
 
	# cp /dev/cdrom /tmp/cd3.iso
	cp: /dev/cdrom: Input/output error
 
	# ls -l /tmp/cd*
	-rw-------    1 root     root       737280 Sep 17 14:09 /tmp/cd1.iso
	-rw-------    1 root     root       737280 Sep 17 14:10 /tmp/cd2.iso
	-rw-------    1 root     root       737280 Sep 17 14:11 /tmp/cd3.iso

Thanks,
Bruce
-- 
Bruce Blinn                               408-615-9100
Mission Critical Linux, Inc.              blinn@MissionCriticalLinux.com
www.MissionCriticalLinux.com

Asking if computers can think is like asking if submarines can swim.
