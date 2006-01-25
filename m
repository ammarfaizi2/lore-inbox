Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWAYPTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWAYPTD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 10:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWAYPTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 10:19:02 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:30887 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751227AbWAYPTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 10:19:01 -0500
Date: Wed, 25 Jan 2006 16:13:46 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jens Axboe <axboe@suse.de>
cc: Albert Cahalan <acahalan@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, schilling@fokus.fraunhofer.de,
       matthias.andree@gmx.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <20060125144543.GY4212@suse.de>
Message-ID: <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
 <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr> <20060125144543.GY4212@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
>- you don't need -scanbus. If
>users think they do, it's either because Joerg brain washed them or
>because they have been used to that bad interface since years ago when
>it was unfortunately needed.

Now you're unfair.
-scanbus does a nice output of what cdwriters (and other capable devices) 
are present. For me, that lists the cd writer and a CF slot from the 
multitype usb flash reader.

There's one kind of not-so-advanced linux newbies that just go to walmart, 
buy a computer and whack a linux system on it for fun, and they still don't 
know if their cdrom is at /dev/hdb or /dev/hdc. Looking for dmesg is 
usually a nightmare for them, and apart that -scanbus lists scsi 
host,id,lun instead of /dev/hd* (don't comment on this kthx), it is 
convenient for this sort of users to find out what's available.

So, and what about that compactflash reader? It is subject to dynamic 
usb->scsi device association (depending on when you connect it, it may 
either become sda, or sdb, or sdc, etc.), and -scanbus yet again provides 
some way (albeit not useful, because it lists scsi,id,lun rather than 
/dev/sd* - don't comment either) to see where it actually is.



Jan Engelhardt
-- 
