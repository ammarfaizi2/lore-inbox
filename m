Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270486AbTHLQGA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 12:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270519AbTHLQGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 12:06:00 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:59142 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S270486AbTHLQF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 12:05:57 -0400
Subject: Re: Linux 2.6 doesn't like Rhythmbox
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: in7y118@public.uni-hamburg.de
Cc: LKML <linux-kernel@vger.kernel.org>, rhythmbox-devel@gnome.org,
       gstreamer-devel@lists.sourceforge.net
In-Reply-To: <1060699703.3f38fe37b8a1f@rzaixsrv6.rrz.uni-hamburg.de>
References: <1060699703.3f38fe37b8a1f@rzaixsrv6.rrz.uni-hamburg.de>
Content-Type: text/plain
Message-Id: <1060704354.856.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 12 Aug 2003 18:05:54 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-12 at 16:48, in7y118@public.uni-hamburg.de wrote:

> Let me explain how threads in Rhythmbox work: The main thread is used for the 
> GUI, other threads (mostly idle) take care of the library - reading out 
> artist/title/... tags and monitoring file changes so the playlists gets updated 
> automagically - and then there is a playback thread. This thread is spawned 
> when playback of a file starts (a new one for each file). It starts by 
> inspecting the file and constructing a pipeline depending on the file type (ogg 
> decoder vs mp3 decoder vs ...). This takes half a second, maybe less. After 
> that it proceeds to do read - decode - output to soundcard looping until the 
> song is done playing.
> The priority according to top starts becoming worse from the beginning of 
> playback and gets worse during playback.
> 
> 
> My question now is simple: Who shall I blame for this?

Don't blame anyone still... There's still ongoing kernel scheduler work.
Please, try the latest -mm patches on top of 2.6.0-test3. You will find
them at ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches.

Experiment with 2.6.0-test3-mm1 to see if it still shows the behaviour
you described.

