Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261910AbTCLTGS>; Wed, 12 Mar 2003 14:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261911AbTCLTGS>; Wed, 12 Mar 2003 14:06:18 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42757 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261910AbTCLTGQ>; Wed, 12 Mar 2003 14:06:16 -0500
Date: Wed, 12 Mar 2003 11:14:52 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: John Bradford <john@grabjohn.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: bio too big device
In-Reply-To: <200303121905.h2CJ5449001606@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.44.0303121111440.15738-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Mar 2003, John Bradford wrote:
> 
> Couldn't we have a list of known good drives, though, and enable 256
> sectors as a special case?

My problem is that I just don't see the point. What's the difference 
between 256 and 254 sectors? 128kB vs 127kB? 

Also, looking closer, the current limit actually seems to be _controller_
dependent, not disk-dependent. I don't know how valid that is, but it
looks reasonable at least in theory - while the IDE controller is mostly a
passthrough thing, it does end up doing part of the work. So the picture
look smore complex than just another drive blacklist.

In short, the headaches just aren't worth the 127->128kB gain.

			Linus

