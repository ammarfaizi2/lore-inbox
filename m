Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265913AbUACGF6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 01:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265917AbUACGF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 01:05:57 -0500
Received: from mail.kroah.org ([65.200.24.183]:58307 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265913AbUACGF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 01:05:56 -0500
Date: Fri, 2 Jan 2004 22:04:39 -0800
From: Greg KH <greg@kroah.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: Tommi Virtanen <tv@tv.debian.net>, Rob Love <rml@ximian.com>,
       Nathan Conrad <lk@bungled.net>, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Message-ID: <20040103060439.GE5306@kroah.com>
References: <3FF34522.8060106@tv.debian.net> <15B77182-3CB9-11D8-A498-000A95A0560C@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15B77182-3CB9-11D8-A498-000A95A0560C@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 01, 2004 at 06:17:43PM -0600, Hollis Blanchard wrote:
> On Wednesday, Dec 31, 2003, at 15:52 US/Central, Tommi Virtanen wrote:
> >I think devfs names are accepted as root= arguments, so that's a bit of
> >a loss.. with udev, your /dev and your root= are equal only if you
> >follow the standard naming.
> >
> >For root=, I can see how early userspace can move that to userspace.
> >But what about swsuspend?
> >
> >Are there any more kernel options taking file names? I think now would
> >be a good time to stop adding more of them :)
> 
> "console=" takes driver-supplied names which usually happen to match 
> /dev node names. For example, drivers/serial/8250.c names itself 
> "ttyS", so "console=ttyS0" will end up going to that driver, regardless 
> of the state of /dev.

These are just string matches that the different console drivers use.
They have nothing to do with an actual /dev node.

thanks,

greg k-h
