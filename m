Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129609AbRCLIdz>; Mon, 12 Mar 2001 03:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129608AbRCLIdp>; Mon, 12 Mar 2001 03:33:45 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:516 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129599AbRCLId3>;
	Mon, 12 Mar 2001 03:33:29 -0500
Date: Fri, 9 Mar 2001 13:36:20 +0000
From: Pavel Machek <pavel@suse.cz>
To: safemode <safemode@voicenet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: incorrect CPU usage readings in 2.2.19prex?
Message-ID: <20010309133620.A31@(none)>
In-Reply-To: <3AA80004.65259634@voicenet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3AA80004.65259634@voicenet.com>; from safemode@voicenet.com on Thu, Mar 08, 2001 at 04:56:20PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Is there something generally wrong with how linux determines total cpu
> usage (via procmeter3 and top) when dealing with applications that are
> threaded?   I routinely get 0% cpu usage when playing mpegs and mp3s and
> some avi's even (Divx when using no software enhancement) ... Somehow i
> doubt that the decoders are so streamlined that they produce <1% cpu
> usage on the computer.  Does anyone know what's going on with this?
> ps shows nearly 0% cpu usage in the threads as well.

CPU usage of programs that sleep after short computation is incorrectly computed

See badboy examples for code that gets 70% of cpu and is reported as getting
0%.

>     i've seen it in these programs
>         freeamp
>         mplayer
> 
> I've seen it in earlier 2.2.19 kernels but i'm using pre14 right now.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

