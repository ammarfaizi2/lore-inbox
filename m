Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266051AbUBJRPn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266049AbUBJRNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:13:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:46977 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266063AbUBJRMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:12:18 -0500
Date: Tue, 10 Feb 2004 18:12:15 +0100
From: Jens Axboe <axboe@suse.de>
To: Stuart Hayes <Stuart_Hayes@dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH (for 2.6.3-rc1) for cdrom driver dvd_read_struct
Message-ID: <20040210171215.GM4109@suse.de>
References: <Pine.LNX.4.44.0402101035050.29125-100000@tux.linuxdev.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402101035050.29125-100000@tux.linuxdev.us.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10 2004, Stuart Hayes wrote:
> The attached patch will make the "dvd_read_struct" function in cdrom.c 
> check that the DVD drive can currently do the DVD read structure command 
> before sending the command to the drive.  It does this by checking the 
> "dvd read" feature using the "get configuration" command.
> 
> Currently, cdrom.c only checks that the drive is a DVD drive before 
> allowing the dvd read structure command to go to the drive--it does not 
> make sure that the DVD drive has a DVD in it.  Without this patch, if CD 
> medium is in a DVD drive, and the DVD_READ_STRUCT ioctl is used, the drive
> will spew an ugly "illegal request" error (magicdev does this).

I'm rather anxious about applying anything like this, in my experience
it's much much safer to simply let the command fail. I don't see
anything technically wrong with your approach, I'd just like it tested
on 100 different dvd drives :)

magicdev should be checking the media type itself first.

-- 
Jens Axboe

