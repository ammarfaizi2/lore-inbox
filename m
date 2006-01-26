Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWAZK1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWAZK1g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 05:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWAZK1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 05:27:36 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:3829 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932278AbWAZK1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 05:27:35 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 26 Jan 2006 11:25:49 +0100
To: zdzichu@irc.pl, schilling@fokus.fraunhofer.de
Cc: rlrevell@joe-job.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, axboe@suse.de, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43D8A3AD.nailDTH8Y1A3Z@burner>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
 <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
 <20060125144543.GY4212@suse.de>
 <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
 <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner>
 <20060125190013.GA6135@irc.pl>
In-Reply-To: <20060125190013.GA6135@irc.pl>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Torcz <zdzichu@irc.pl> wrote:

> > > need to use /dev/hda, but /dev/cdrecorder or whatever. A real user would
> > > likely be using k3b or something graphical though, and just click on his
> > > Hitachi/Plextor/whatever burner. Perhaps some fancy udev rules could
> > > help do this dynamically even.
> > 
> > Guess why cdrecord -scanbus is needed.
> > 
> > It serves the need of GUI programs for cdrercord and allows them to retrieve 
> > and list possible drives of interest in a platform independent way.
>
>   GUI programs tend to retrieve this kind of info form HAL
> (http://freedesktop.org/wiki/Software_2fhal)

I am not sure what you like to tell with this.

Programs that depend on specific Linux behavior tend to be non-portable (see 
e.g. nautilus on GNOME). Nautilus tries to get e.g. the drive write speeds
by reading /prov/scsi/******. Besides the fact that this is not available 
elsewhere, it gives incorrect results because there are a lot of DVD writers 
with broken firmware.

Cdrecord implements workarounds for this kind of problems and for this reason, 
the most portable solution for a GUI is to use cdrecord to retrieve the 
information.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
