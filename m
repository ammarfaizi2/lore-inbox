Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262389AbRFQRyH>; Sun, 17 Jun 2001 13:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262076AbRFQRx5>; Sun, 17 Jun 2001 13:53:57 -0400
Received: from ohiper1-122.apex.net ([209.250.47.137]:24326 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S262389AbRFQRxr>; Sun, 17 Jun 2001 13:53:47 -0400
Date: Sun, 17 Jun 2001 12:53:15 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: a memory-related problem?
Message-ID: <20010617125315.A24430@hapablap.dyn.dhs.org>
In-Reply-To: <CDEJIPDFCLGDNEHGCAJPOEFGCCAA.rbultje@ronald.bitfreak.net> <9gi848$pb2$1@ns1.clouddancer.com> <20010617131002.EF84D784BD@mail.clouddancer.com> <992806021.2007.0.camel@tux.bitfreak.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <992806021.2007.0.camel@tux.bitfreak.net>; from rbultje@ronald.bitfreak.net on Sun, Jun 17, 2001 at 09:26:50PM +0200
X-Uptime: 10:23am  up 16:48,  0 users,  load average: 1.32, 1.77, 1.74
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Probably what happens is that your BIOS stores some data in the top
megabyte of RAM, but doesn't set up the memory map to reflect this.
Therefore, Linux overwrites whatevers up there, causing problems.

On Sun, Jun 17, 2001 at 09:26:50PM +0200, Ronald Bultje wrote:
> P6b has three mem-slots. I would get "unresolved errors in init" if I
> had 2x64+1x128 sticks, and I would get oopses if I had 2x128M sticks. So
> there is indeed a weird difference.
> I just noticed this: if I supply "linux-2.4.4 mem=255M" instead of
> "linux-2.4.4 mem=256M" at the lilo prompt, it does work. Is this a bug
> in the code that handles options given at startup-time? (I only tried
> this for 2x128 sticks but I suppose this is the same for 2x64+1x128
> sticks - I guess I'm too lazy to try it out).
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
