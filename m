Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262102AbSJIWGC>; Wed, 9 Oct 2002 18:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262108AbSJIWGC>; Wed, 9 Oct 2002 18:06:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39943 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262102AbSJIWGB>; Wed, 9 Oct 2002 18:06:01 -0400
Date: Wed, 9 Oct 2002 15:10:08 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tim Hockin <thockin@hockin.org>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.41 s390 (8/8): 16 bit uid/gids.
In-Reply-To: <200210091824.g99IOkI18617@www.hockin.org>
Message-ID: <Pine.LNX.4.44.0210091508050.24776-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Oct 2002, Tim Hockin wrote:
> > 
> > In other words, that __UID16 thing should be a real CONFIG_XXX option.
> 
> Because Sparc64/s390x/? still need to tell highuid.h to do macro magic for
> NEW_TO_OLD_UID() and friends in some places and not others.  A CONFIG_XXX
> applies all the time to all files.

If __UID16 works, then renaming it to CONFIG_UID16_ONLY _must_ also work. 

I don't understand your argument about other architectures. I'm claiming 
that __UID16 is a config option, and that it must be renamed to _show_ 
that it is a config option.

If the renaming results in code that doesn't work, then the code didn't 
work in the first place or your cpp is incredibly broken.

WE MUST NOT HAVE CONFIG OPTIONS THAT ARE HIDDEN AND CALLED __UID16! That's 
my whole point.

		Linus

