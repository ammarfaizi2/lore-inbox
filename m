Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263014AbUKYH5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbUKYH5V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 02:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbUKYH5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 02:57:21 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:47788 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263014AbUKYH5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 02:57:17 -0500
Date: Thu, 25 Nov 2004 08:56:46 +0100
From: Jens Axboe <axboe@suse.de>
To: Thomas Fritzsche <tf@noto.de>
Cc: linux-kernel@vger.kernel.org, david@2gen.com
Subject: Re: Re: Is controlling DVD speeds via SET_STREAMING supported?
Message-ID: <20041125075646.GD10233@suse.de>
References: <33356.192.168.0.2.1101334593.squirrel@192.168.0.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33356.192.168.0.2.1101334593.squirrel@192.168.0.10>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24 2004, Thomas Fritzsche wrote:
> Hi David,
> 
> I had the same problem with my DVD+-RW NEC-ND 3500 (NEC-support told me
> that they didn't support linux :-( ). After googling I couldn't find an
> answer. Because I didn't know anything about ide-cd (yesterday ;-))  I
> read in this spec about the SET STREAMING command:
> ftp://ftp.avc-pioneer.com/Mtfuji_4/Spec/Fuji4r10.pdf
> If you also read the newer Specs (Mtfuji_5) then you'll find out that the
> "SET CD SPEED" command is "only applicable to CD-R/RW logical units".
> It looks like older DVD-Drives also support this command, but newer do not
> support this for DVD+-R. But there is also the SET STREAMING command as
> Jens Axboe described on this list. Not all devices support this feature
> but my NEC-CD 3500 does (as I found out ;-) / my Teac-CD-RW does not)
> 
> I wrote a little programm to test this SET STREAMING command (quick &
> dirty). In my opinion it would make sence to also enhance the kernel
> function cdrom_select_speed (linux/drivers/ide/ide-cd.c), so that this
> function works also for "newer" DVD-drives.
> (!first check for the Realtime-Streaming-Feature and then use the right
> command to set the speed). Because DVD+-RW Drives will be faster (AND
> LOUDER!!) very soon it would be nice to have this in the kernel.

I agree, I'll do a patch for this right now. Your example code looks
fine. My only worry is that some drives might complain if your end_lba
is larger than the capacity, I'll have to double check the spec.

-- 
Jens Axboe

