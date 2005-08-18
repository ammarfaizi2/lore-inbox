Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbVHRUuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbVHRUuM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 16:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVHRUuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 16:50:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:3806 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932411AbVHRUuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 16:50:10 -0400
Date: Thu, 18 Aug 2005 22:49:04 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>
Subject: Re: HDAPS, Need to park the head for real
Message-ID: <20050818204904.GE516@openzaurus.ucw.cz>
References: <1124205914.4855.14.camel@localhost.localdomain> <20050816200708.GE3425@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050816200708.GE3425@suse.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I would suggest some sysfs file for doing this. The best approach would

Actually it is usefull for other devices, too... for power saving.

Some people call it "runtime power managment".

> sysfs attribute for this and we integrate a proper solution once the
> request type stuff is finalized. As the user api, I would suggest just
> echoing a timeout in seconds to the file. So:
> 
> # echo 5 > /sys/block/hda/device/freeze
> 
> would park the head, freeze queue, and unfreeze in 5 seconds.

Please make it "echo 1 > frozen", then userspace can do "echo 0 > frozen"
after five seconds.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

