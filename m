Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290588AbSBKW7w>; Mon, 11 Feb 2002 17:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290586AbSBKW7m>; Mon, 11 Feb 2002 17:59:42 -0500
Received: from 212.muaa.snjs.sfjca01r1.dsl.att.net ([12.98.126.212]:44570 "HELO
	homa.asicdesigners.com") by vger.kernel.org with SMTP
	id <S290588AbSBKW7a>; Mon, 11 Feb 2002 17:59:30 -0500
Date: Mon, 11 Feb 2002 14:58:33 -0800
From: Mike Mackovitch <macko@chelsio.com>
To: John Hesterberg <jh@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: driver location for platform-specific drivers
Message-ID: <20020211145833.A3635@wacko.asicdesigners.com>
In-Reply-To: <20020211131744.A16032@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20020211131744.A16032@sgi.com>; from jh@sgi.com on Mon, Feb 11, 2002 at 01:17:44PM -0600
X-OriginalArrivalTime: 11 Feb 2002 23:01:00.0578 (UTC) FILETIME=[F9151020:01C1B34F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2002 at 01:17:44PM -0600, John Hesterberg wrote:
> 
> For SGI's upcoming Linux platform (nicknamed Scalable Node, or SN),
> we have some platform specific device drivers.  Where should these go?
> I see several precedents in the current kernels.
> 
> [...]
> 
>     2) Company (sgi) directory.
>        There is already an sgi directory, strangely enough.
>        I *think* this was meant to be a platform directory for the
>        discontinued SGI 320/540 Visual Workstations.  However, maybe

You are mistaken.  The cruft in drivers/sgi mostly dates back to the
attempts on the SGI Indy platform to get SGI's IRIX X server *binary*
running under Linux (note that this work was NOT done by SGI).

The SGI Visual Workstation work was mostly done within the i386 arch
code; the framebuffer driver (sgivwfb.[ch]) was put in drivers/video;
and some other drivers had some modifications that were guarded
by CONFIG_VISWS or CONFIG_VISWS_HACKS.  (There was also a project that
enabled multi-process accelerated/direct-rendered graphics on that
platform, but that code was never released due to the fact that the
project was killed the week it was demonstrated at SIGGRAPH'99.)

--macko
