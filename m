Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268849AbUHaTPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268849AbUHaTPs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 15:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268911AbUHaTM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:12:59 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:21953 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S268851AbUHaTLk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:11:40 -0400
Message-ID: <4134CDF0.7070600@drzeus.cx>
Date: Tue, 31 Aug 2004 21:13:52 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040704)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: MMC block major dev
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the MMC block layer hasn't been assigned a major number. 
The code registers the block dev with a uninitialized variable. It then 
proceeds to create a mmc dir under devfs. Since I'm not using devfs this 
then poses a problem.

Some debug statements revealed that the driver ended up on major number 
254. I'm not familiar with how kernel memory is initialized but using an 
uninitialized variable should result in random numbers. It seems to get 
254 each time though. Can I count on this? (i.e. can I safely create 
device node files with this major).

Rgds
Pierre Ossman

