Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266461AbUGVElT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266461AbUGVElT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 00:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266692AbUGVElT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 00:41:19 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:28880 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266461AbUGVElS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 00:41:18 -0400
Message-ID: <40FF4563.5070407@comcast.net>
Date: Thu, 22 Jul 2004 00:41:07 -0400
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Jens Axboe <axboe@suse.de>
Subject: Re: audio cd writing causes massive swap and crash
References: <40F9854D.2000408@comcast.net> <20040718071830.GA29753@suse.de> <40FBBAAE.5060405@comcast.net> <40FC2E60.2030101@comcast.net>
In-Reply-To: <40FC2E60.2030101@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had other people test writing.  It appears that scsi-emu is not 
effected by this memory leak when writing audio cds.  So it would appear 
that ide-cd along with any of the dependent ide source files is the 
culprit. But I cannot find anywhere in ide-cd that is apparent to being 
a mem leak.  There are various conditions in ide_do_drive_cmd that state 
that the cdrom driver has to be very careful about handling but without 
intimate knowledge of the driver, I can't be sure that it's sufficiently 
handling those situations.  

Surprisingly, it's very hard to find anyone who's used the native atapi 
mode to write an audio cd in 2.6.  Which is partly why this problem 
hasn't generated more mail traffic here I would guess. 
