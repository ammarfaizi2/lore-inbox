Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261522AbTC3Tbn>; Sun, 30 Mar 2003 14:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261526AbTC3Tbn>; Sun, 30 Mar 2003 14:31:43 -0500
Received: from [195.39.17.254] ([195.39.17.254]:15620 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261522AbTC3Tbl>;
	Sun, 30 Mar 2003 14:31:41 -0500
Date: Sat, 29 Mar 2003 00:12:48 +0100
From: Pavel Machek <pavel@suse.cz>
To: Erik Hensema <erik@hensema.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Delaying writes to disk when there's no need
Message-ID: <20030328231248.GH5147@zaurus.ucw.cz>
References: <slrnb843gi.2tt.usenet@bender.home.hensema.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrnb843gi.2tt.usenet@bender.home.hensema.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> In all kernels I've tested writes to disk are delayed a long time even when
> there's no need to do so.
> 
> A very simple test shows this: on an otherwise idle system, create a tar of
> a NFS-mounted filesystem to a local disk. The kernel starts writing out the
> data after 30 seconds, while a slow and steady stream would be much nicer
> to the system, I think.
> 

Well, doing writeback sooner when disks
are idle might be good idea; detecting
if disk is idle might not be too easy, through.

OTOH, raid resync already has some
such detection?
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

