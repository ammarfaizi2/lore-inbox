Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267353AbUJDN6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267353AbUJDN6g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 09:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267449AbUJDN6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 09:58:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:38832 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267353AbUJDN6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 09:58:34 -0400
Date: Mon, 4 Oct 2004 15:55:44 +0200
From: Jens Axboe <axboe@suse.de>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, linux-kernel@vger.kernel.org
Subject: Re: [bug] 2.6.8: CDROM_SEND_PACKET ioctls failing as non-root on ide scsi drives
Message-ID: <20041004135544.GW2287@suse.de>
References: <20041004130941.GE19341@lkcl.net> <6u4qlaehlw.fsf@zork.zork.net> <20041004133610.GT2287@suse.de> <6uu0tad24s.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6uu0tad24s.fsf@zork.zork.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04 2004, Sean Neakums wrote:
> Jens Axboe <axboe@suse.de> writes:
> 
> > On Mon, Oct 04 2004, Sean Neakums wrote:
> >> CDROM_SEND_PACKET calls down to sg_io, which calls verify_command,
> >> which will not permit anyone but root to use any unrecognised
> >> commands.  GET CONFIGURATION does not seems to be one of those
> >> recognised.  This check for unrecognised commands is a fairly recent
> >> addition, IIRC.
> >
> > 2.6.8 didn't have any command granularity, you must be root to issue any
> > comand there.
> 
> I was looking at 2.6.8.1 when I wrote the above, although it's
> possible my eye skipped over something.
> 
> verify_command certainly seems to do the check:
> 
> http://lxr.linux.no/source/drivers/block/scsi_ioctl.c?v=2.6.8.1#L113
> 
> And it looks the same in the 2.6.8 tree I have here, too.

You are right, it was added before, my recollection of the events
apparently isn't so good either. You are right in that GET_CONFIGURATION
was added later, post 2.6.8 release.

> (Not trying to be an ass, just concerned about my reading comprehension.)

:-)

-- 
Jens Axboe

