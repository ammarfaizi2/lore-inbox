Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266665AbUBETyz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 14:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266698AbUBETyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 14:54:55 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2944 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266665AbUBETyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 14:54:53 -0500
Date: Thu, 5 Feb 2004 20:04:11 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402052004.i15K4Bqx000266@81-2-122-30.bradfords.org.uk>
To: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>
Cc: Tomas Zvala <tomas@zvala.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20040205182335.GB294@elf.ucw.cz>
References: <20040203131837.GF3967@aurora.fi.muni.cz>
 <Pine.LNX.4.53.0402030839380.31203@chaos>
 <401FB78A.5010902@zvala.cz>
 <20040203152805.GI11683@suse.de>
 <20040205182335.GB294@elf.ucw.cz>
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> mount
> umount
> cdrecord -blank
> mount
> see old data
> 
> That looks pretty bad. If there's no other solution, we might just
> document it, but...

I think cdrecord should be hacked to complain loudly if the device is
already mounted.  Regardless of the device cache not being cleared,
(which is a firmware bug, in my opinion), blanking a mounted device is
usually not what the user intended.  This is not a kernel problem as
such, and should be dealt with in userspace.

John.
