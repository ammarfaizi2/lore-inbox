Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262528AbSKMUv6>; Wed, 13 Nov 2002 15:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262646AbSKMUv5>; Wed, 13 Nov 2002 15:51:57 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:37131 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262528AbSKMUv5>;
	Wed, 13 Nov 2002 15:51:57 -0500
Date: Wed, 13 Nov 2002 21:58:44 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: make distclean and make dep??
Message-ID: <20021113205844.GB2822@mars.ravnborg.org>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0211131417480.32544-100000@oddball.prodigy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211131417480.32544-100000@oddball.prodigy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 02:32:27PM -0500, Bill Davidsen wrote:
> When I do a "make distclean" in a tree, should not that roll it back to a 
> clean empty tree? I noticed that when I did that no work was done by "make 
> dep" in the rebuild.
With the recent module related changes CONFIG_MODVERSIONS has disappeared.
Therefore make dep became a noop.

> Distclean is supposed to be even cleaner than mrproper (to build a clean
> tree for distribution) and this behaviour is new.
distclean and mrproper has been merged as of 2.44 IIRC.
So mrproper and distclean behave in the same way.

> Also noted, somewhere between 2.5.45 and 2.5.46 distclean vanished from 
> "make help." It's really useful to have distclean work to build patched 
> kernels for distribution, hopefully this is an oversight and not a new 
> policy.
Since they are equal I removed the help for the less used version.

	Sam
