Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267499AbTAGVvF>; Tue, 7 Jan 2003 16:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267509AbTAGVvF>; Tue, 7 Jan 2003 16:51:05 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:31492 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267499AbTAGVug>; Tue, 7 Jan 2003 16:50:36 -0500
Date: Tue, 7 Jan 2003 21:59:14 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Andres Salomon <dilinger@voxel.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.54 atyfb_base.c compile fix
In-Reply-To: <20030106220956.GA32140@chunk.voxel.net>
Message-ID: <Pine.LNX.4.44.0301072157280.17129-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have too many other projects I'm working on right now to dedicate a
> lot of time trying to fix it, but if you had suggestions for what to
> try, I'd appreciate it.
> 
> Simply loading the atyfb module, without any args, causes the screen to
> go blank.  I can see the cursor blinking, but I can't see any text
> output.

These means atyfb changes the video mode when you insmod. Since the card 
usually has a VGA core we shouldn't set the video mode when insmoding. 
This way we can insmod the driver and still have VGA text mode. Then 
insmoding font.ko and fbcon.ko would load framebuffer console. 



