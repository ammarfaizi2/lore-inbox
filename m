Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWACQxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWACQxG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 11:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWACQxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 11:53:05 -0500
Received: from tower.bj-ig.de ([194.127.182.2]:46486 "EHLO fs.bj-ig.de")
	by vger.kernel.org with ESMTP id S932424AbWACQxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 11:53:00 -0500
Message-ID: <43BAABF0.7080507@bj-ig.de>
Date: Tue, 03 Jan 2006 17:53:04 +0100
From: =?ISO-8859-1?Q?Ralf_M=FCller?= <ralf@bj-ig.de>
User-Agent: Mozilla Thunderbird 1.0.7 (Macintosh/20050923)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, linux-ide@vger.kernel.org
Subject: Re: hdparm -C always give drive state is standby (was: Kernel panic
	with 2.6.15-rc7 + libata1 patch)
References: <43B724BA.90405@bj-ig.de>	<43B7EA0A.7040805@bj-ig.de>	<20060101145702.GV3811@stusta.de>	<43B806C7.5000607@bj-ig.de>
	<43B93375.1020701@rtr.ca>
In-Reply-To: <43B93375.1020701@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Delivered-For: jgarzik@pobox.com
X-Spambayes-Classification: ham; 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord schrieb:
> Ralf Müller wrote:
>> A further problem is that calling "hdparm -C" _always_ give "drive 
>> state is:  standby" - even when the disks are clearly active. Maybe 
>> this indicates something to you.
> 
> 
> MMmm.. yes, it does that here, too.
> This is probably a bug somewhere in the libata passthru code,
> or in the HDIO_* translation code.

If I'm right that this should be handled in "ata_cmd_ioctl()" then there 
  is no copy_to_user() at all for WIN_CHECKPOWERMODE[12] - so there is 
no chance to get data back. Are there any known plans to fix this?

Ralf

