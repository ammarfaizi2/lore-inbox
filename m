Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751677AbWHTIYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbWHTIYk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 04:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbWHTIYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 04:24:40 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:43139 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751363AbWHTIYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 04:24:39 -0400
Date: Sun, 20 Aug 2006 10:22:56 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Denis Vlasenko <vda.linux@googlemail.com>
cc: Eric Piel <Eric.Piel@tremplin-utc.net>, mplayer-users@mplayerhq.hu,
       linux-kernel@vger.kernel.org
Subject: Re: mplayer + heavy io: why ionice doesn't help?
In-Reply-To: <200608192004.10326.vda.linux@googlemail.com>
Message-ID: <Pine.LNX.4.61.0608201021340.9707@yvahk01.tjqt.qr>
References: <200608181937.25295.vda.linux@googlemail.com>
 <44E6006C.2030406@tremplin-utc.net> <200608192004.10326.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>It helps. mplayer skips much less, but still some skipping is present.

Try with -ao alsa, then it should skip less, or at least, if it skip, skip 
back so that less audio is lost.
When playing audio-only files, it is always wise to specify e.g. -cache 320
which proved to be a good value for my workloads.

>I experimented with forcing entire file to be present in the
>pagecache, and in this case mplayer almost never skips.
>
>Looks like mplayer have very little tolerance for reads
>randomly taking more time to read input stream.
>
>However, I then looked into the mplayer's source
>(I wondered why it doesn't do read buffering itself)...
>
>The code is, um, less than pretty.

Jan Engelhardt
-- 
