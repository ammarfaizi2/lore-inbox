Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266117AbUJDNto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266117AbUJDNto (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 09:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267353AbUJDNto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 09:49:44 -0400
Received: from zork.zork.net ([64.81.246.102]:8836 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S266117AbUJDNtm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 09:49:42 -0400
To: Jens Axboe <axboe@suse.de>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, linux-kernel@vger.kernel.org
Subject: Re: [bug] 2.6.8: CDROM_SEND_PACKET ioctls failing as non-root on ide scsi drives
References: <20041004130941.GE19341@lkcl.net> <6u4qlaehlw.fsf@zork.zork.net>
	<20041004133610.GT2287@suse.de>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Jens Axboe <axboe@suse.de>, Luke Kenneth Casson Leighton
	<lkcl@lkcl.net>, linux-kernel@vger.kernel.org
Date: Mon, 04 Oct 2004 14:49:39 +0100
In-Reply-To: <20041004133610.GT2287@suse.de> (Jens Axboe's message of "Mon, 4
	Oct 2004 15:36:10 +0200")
Message-ID: <6uu0tad24s.fsf@zork.zork.net>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> On Mon, Oct 04 2004, Sean Neakums wrote:
>> CDROM_SEND_PACKET calls down to sg_io, which calls verify_command,
>> which will not permit anyone but root to use any unrecognised
>> commands.  GET CONFIGURATION does not seems to be one of those
>> recognised.  This check for unrecognised commands is a fairly recent
>> addition, IIRC.
>
> 2.6.8 didn't have any command granularity, you must be root to issue any
> comand there.

I was looking at 2.6.8.1 when I wrote the above, although it's
possible my eye skipped over something.

verify_command certainly seems to do the check:

http://lxr.linux.no/source/drivers/block/scsi_ioctl.c?v=2.6.8.1#L113

And it looks the same in the 2.6.8 tree I have here, too.

(Not trying to be an ass, just concerned about my reading comprehension.)
