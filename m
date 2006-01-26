Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWAZOML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWAZOML (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 09:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWAZOMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 09:12:10 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:55536 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932323AbWAZOMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 09:12:09 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 26 Jan 2006 15:11:04 +0100
To: zdzichu@irc.pl, schilling@fokus.fraunhofer.de
Cc: rlrevell@joe-job.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, axboe@suse.de, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43D8D878.nailE2XDSCDWK@burner>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
 <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
 <20060125144543.GY4212@suse.de>
 <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
 <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner>
 <20060125190013.GA6135@irc.pl> <43D8A3AD.nailDTH8Y1A3Z@burner>
 <20060126105640.GA5608@irc.pl>
In-Reply-To: <20060126105640.GA5608@irc.pl>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Torcz <zdzichu@irc.pl> wrote:

>   This is a fallback if HAL isn't available.  Normally this is done by:
>
> drive->max_speed_write = libhal_device_get_property_int
>                                 (ctx, device_names [i],
>                                  "storage.cdrom.write_speed",
>                                  NULL)
>                                 / CD_ROM_SPEED;
>
>  (natilus-burn-drive.c:1368 from version 2.12.0).

Even if this works under good conditions, it will fail in many cases 
because the related software is not up to date with recent device formware bugs.
Cdrecord is kept up to date as it either deals with a new drive or not.

Delegating things to other instances only works ar long as there are clean ans 
stable interfaces. This unfortunately does not apply to CD/DVD/HD-DVD.

> > Cdrecord implements workarounds for this kind of problems and for this reason, 
> > the most portable solution for a GUI is to use cdrecord to retrieve the 
> > information.
>
>   Yeah, sure.
>                   /* FIXME we don't have any way to guess the real device
>                    * from the info we get from CDRecord */
>
>  (the only FIXME in above mentioned file).

And guess why Sun is currently working on a work around this nautilus problem.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
