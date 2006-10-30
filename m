Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbWJ3SKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWJ3SKW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 13:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbWJ3SKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 13:10:22 -0500
Received: from 8.ctyme.com ([69.50.231.8]:22409 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S964977AbWJ3SKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 13:10:21 -0500
Message-ID: <4546400C.1090500@perkel.com>
Date: Mon, 30 Oct 2006 10:10:20 -0800
From: Marc Perkel <marc@perkel.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux Freezes during disk IO on Asus M2NPV-VM nVidia chipset - raid
 0 related?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: darwin.ctyme.com - http://www.junkemailfilter.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to track down my remaining lockup problem with Linux using my 
first AMD AM2 motherboard. It's been a nightmare, but it's getting 
better. but I think it might be a Linux bug. But I have some specific 
info that might lead to something.

This motherboard use nVidia GeForce 6150 chipset
The computer seems to only freeze up during disk IO - specifically when 
downloading using rsync.
It also seems to lock up when writing data to a RAID 0 EXT3 filesystem. 
I'm using software raid.

I'm currently running the stock Fedora Core 6 kernel based on 1.6.18.1

After several lockups I tried reformatting the partition to see if 
perhaps the data was so screwed up that it was the problem. The reformat 
didn't fix it.

It also seems that when it does crash that recovery isn't as clean as it 
usually is. It seems that I have to run e2fsck manually more often than 
usual and that it find more things to fix. Other drives that are not 
part of raid seem to not have this issue.

I hope this is enough information to help track this down.


