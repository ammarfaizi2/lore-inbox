Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266173AbUALNlb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 08:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266185AbUALNlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 08:41:31 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:8780 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S266173AbUALNl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 08:41:29 -0500
Message-ID: <4002A3FC.3000000@samwel.tk>
Date: Mon, 12 Jan 2004 14:41:16 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan De Luyck <lkml@kcore.org>
CC: linux-kernel@vger.kernel.org, Dax Kelson <dax@gurulabs.com>,
       Kiko Piris <kernel@pirispons.net>, Bartek Kania <mrbk@gnarf.org>,
       Simon Mackinlay <smackinlay@mail.com>
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
References: <3FFFD61C.7070706@samwel.tk> <200401121212.44902.lkml@kcore.org> <4002836A.8050908@samwel.tk> <200401121343.34688.lkml@kcore.org>
In-Reply-To: <200401121343.34688.lkml@kcore.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan De Luyck wrote:
>>2. Stop klogd, do "echo 1 > /proc/sys/vm/block_dump" and see which
>>process keeps your disk spun up using dmesg.
> 
> Welll.... i see no READs, and the writes i see is spamd, kmail, pdflush, 
> reiserfs/0.

How are the WRITEs grouped, are they grouped together or do they seem to 
occur more evenly spaced? When you use "sync", how long until the next 
WRITE? What are the values of /proc/sys/vm/dirty_expire_centisecs and 
/proc/sys/vm/dirty_writeback_centisecs? Are you sure you are running a 
kernel that supports the commit= option with reiserfs? (This option was 
added in 2.6.1.)

I've never tested laptop mode with reiserfs BTW, does anybody else here 
have experience with laptop mode and reiserfs?

-- Bart
