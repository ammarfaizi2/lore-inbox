Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbVJJLH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbVJJLH6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 07:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVJJLH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 07:07:58 -0400
Received: from swm.pp.se ([195.54.133.5]:14521 "EHLO uplift.swm.pp.se")
	by vger.kernel.org with ESMTP id S1750747AbVJJLH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 07:07:58 -0400
Date: Mon, 10 Oct 2005 13:07:56 +0200 (CEST)
From: Mikael Abrahamsson <swmike@swm.pp.se>
To: linux-kernel@vger.kernel.org
Subject: Re: 3Ware 9500S-12 RAID controller -- poor performance
In-Reply-To: <20051010105423.GA11982@gallifrey>
Message-ID: <Pine.LNX.4.62.0510101303310.24341@uplift.swm.pp.se>
References: <4346EA35.90700@uklinux.net> <20051010104217.20341.qmail@web30305.mail.mud.yahoo.com>
 <20051010105423.GA11982@gallifrey>
Organization: People's Front Against WWW
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2005, Dr. David Alan Gilbert wrote:

> Nice.  Have you tried Software RAID5 on top of that? I would be very 
> interested to know how software RAID5 goes relative to the 3Ware 
> hardware.

There have been hundreds of email regarding this on the 
linux-raid@vger.kernel.org list. Please look in the archives.

It's well known that 3ware hw raid is slow when writing, current theory is 
that this is due to the lack of buffering meaning that any write makes it 
read a lot as well, destroying performance. Generally, the performance 
numbers advertised by 3ware when writing is a dd to the drive itself (I 
got this number after doing a support request on it a few years back), 
without a filesystem. This goes very quickly, but writing files on a 
filesystem is usually very slow (10 megabyte/s or so). When doing SW raid 
the SW layer has access to the memory block cache and can thus avoid a lot 
of physical reads on the drives.

I never had any problems getting good read speeds on the HW raid.

My experience is with the 7500 series, the 9500 series has cache as well 
but this doesn't seem to have solved a lot of the performance problems 
seen with the 7500 series.

-- 
Mikael Abrahamsson    email: swmike@swm.pp.se
