Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316446AbSE3HXp>; Thu, 30 May 2002 03:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316444AbSE3HXo>; Thu, 30 May 2002 03:23:44 -0400
Received: from schwerin.p4.net ([195.98.200.5]:15962 "EHLO schwerin.p4.net")
	by vger.kernel.org with ESMTP id <S316441AbSE3HXo>;
	Thu, 30 May 2002 03:23:44 -0400
Message-ID: <3CF5D424.2060500@p4all.de>
Date: Thu, 30 May 2002 09:26:28 +0200
From: Michael Dunsky <michael.dunsky@p4all.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Peter Chubb <peter@chubb.wattle.id.au>
Subject: Re: Strange code in ide_cdrom_register
In-Reply-To: <15605.34861.599803.405864@wombat.chubb.wattle.id.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Peter Chubb wrote:
 > Hi,
 > 	This code snippet in ide_cdrom_register() seems really
 > strange...
 >
 > 	devinfo->ops = &ide_cdrom_dops;
 > 	devinfo->mask = 0;
 >
 >>>>	*(int *)&devinfo->speed = CDROM_STATE_FLAGS (drive)->current_speed;
 >>>>	*(int *)&devinfo->capacity = nslots;
 >>>
 > 	devinfo->handle = (void *) drive;
 > 	strcpy(devinfo->name, drive->name);
 >
 > devinfo->speed and devinfo->capacity are both ints.  So the casts are
 > just a disaster waiting to happen, if the types of capacity or speed
 > ever change?

Just take a quick look in drivers/ide/ide-cd.h: values "nslots" and
"current_speed" are of type "byte", so we need to cast to store them 
(like that) into the integer-vars. Nothing strange there....


 > Peter C
 >

ciao

Michael


