Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263359AbSIUTXR>; Sat, 21 Sep 2002 15:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263374AbSIUTXR>; Sat, 21 Sep 2002 15:23:17 -0400
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:27094
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S263359AbSIUTXR>; Sat, 21 Sep 2002 15:23:17 -0400
Date: Sat, 21 Sep 2002 15:28:22 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Dan Aloni <da-x@gmx.net>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix to strchr() in lib/string.c
In-Reply-To: <20020921173033.GB19943@callisto.yi.org>
Message-ID: <Pine.LNX.4.44.0209211518341.15918-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Sep 2002, Dan Aloni wrote:

> On Sat, Sep 21, 2002 at 12:25:59PM -0400, Nicolas Pitre wrote:
> > 
> > The return value of strchr("foo",0) should be the start address of
> > "foo" + 3, not NULL.
> 
> Correct me if I'm wrong, but no fix is needed.
> 
> strchr("foo", 0) doesn't return NULL, for the simple fact that 
> the loop will stop when reaching '\0' before the 'if' that returns
> NULL, and then s will be returned.

Doh.  You're right.

I was fixing some architecture specific version and someone I usually trust
led me to believe this one was broken too, and I obviously didn't look
carefully enough.

(no no I won't say it was you Russell)  ;-)


Nicolas

