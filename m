Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312194AbSDXN4m>; Wed, 24 Apr 2002 09:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312212AbSDXN4l>; Wed, 24 Apr 2002 09:56:41 -0400
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:15002 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S312194AbSDXN4l>; Wed, 24 Apr 2002 09:56:41 -0400
Date: Wed, 24 Apr 2002 10:01:58 -0400
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, dalecki@evision-ventures.com
Subject: Re: 2.5.9 -- OOPS in IDE code (symbolic dump and boot log included)
Message-ID: <20020424100158.A21685@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > > Oops on 2.5.9 at boot time.

> Look, the problem is easy. Backout the changes to ide_cdrom_do_request()
> and cdrom_start_read(), then re-add the
> 
>        HWGROUP(drive)->rq->special = NULL;
>
> in cdrom_end_request() before calling ide_end_request()
>
> Something ala, completely untested (not even compiled). See the thread
> about the ide-cd changes being broken.

That works!  Applied to 2.5.10, compiled and booted.
Mounted a cdrom and that works too.

Thanks!
-- 
Randy Hron

