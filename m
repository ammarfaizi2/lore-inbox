Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273333AbRJYQHK>; Thu, 25 Oct 2001 12:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274248AbRJYQHA>; Thu, 25 Oct 2001 12:07:00 -0400
Received: from hatrack.unc.edu.ar ([170.210.248.6]:19908 "EHLO
	hatrack.unc.edu.ar") by vger.kernel.org with ESMTP
	id <S273976AbRJYQGu>; Thu, 25 Oct 2001 12:06:50 -0400
Date: Thu, 25 Oct 2001 13:02:41 -0300 (ART)
From: Marcos Dione <mdione@hal.famaf.unc.edu.ar>
To: Andreas Dilger <adilger@turbolabs.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: kjournald and disk sleeping
In-Reply-To: <20011022124751.C5146@turbolinux.com>
Message-ID: <Pine.LNX.4.30.0110251300150.1510-100000@multivac.famaf.unc.edu.ar>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001, Andreas Dilger wrote:

> Hmm.  I have a laptop running with all ext3 filesystems, and it has no
> problems spinning down the disk.  I have not done anything to increase
> the flush interval of kjournald.  It may be that kjournald is writing
> to disk because you have things which are trying to write to disk.

	indeed, seems that a lot of apps like to access the disk when
they're doing nothing. now I have two approaches: one is to find them all,
the other is to simply stomp almos all the apps, includin servers. tonight
I'll make some tests.

> I have all of the filesystems on my laptop mounted noatime (this breaks
> /tmp auto-cleanup, but oh well) and I have moved all of the entries from
> /etc/cron.hourly to /etc/cron.daily, as they are not so critical for me.

	this may help too, thanks.

-- 
"y, bueno, yo soy muy ilogico. lo que pasa es que ustedes me toman
demasiado en serio"
                                          --JLB

