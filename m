Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129317AbRBPS1J>; Fri, 16 Feb 2001 13:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129321AbRBPS07>; Fri, 16 Feb 2001 13:26:59 -0500
Received: from uhura.concentric.net ([206.173.118.93]:23188 "EHLO
	uhura.concentric.net") by vger.kernel.org with ESMTP
	id <S129317AbRBPS0o>; Fri, 16 Feb 2001 13:26:44 -0500
Date: Fri, 16 Feb 2001 10:26:27 -0800 (PST)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@zeus.concentric.net>
To: Louis Garcia <louisg00@bellsouth.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Video drivers and the kernel
Message-ID: <Pine.LNX.4.31.0102160943150.25300-100000@zeus.concentric.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I was wondering why video drivers are not part of the kernel like every
>other piece of hardware. I would think if video drivers were part of the
>kernel and had a nice API for X or any other windowing system, would not
>only improve performance but would allow competing windowing systems
>without having to develop drivers for each. Has anyone thought or
>rejected this idea.

Hi!

  Their are two schools of though which I have encountered. One is have
everything in userland. The second is have everything in the kernel. Well
both are wrong. What is really needed? Proper virtualization of the
graphics engine. This means the graphics hardware state is private to each
process and no other process can effect another process graphics hardware
state. This is all that is needed. DRI attemptes to address this. Will
their be more kernel support in the future. Yes if you every want to port
high end graphic servers. Here you end up dealing with with pipes on
different nodes in NUMA systems. Data is passed from node to node to allow
really fast parallel rendering. Note even in this case you don't have
the hardware programmed in the driver but only management of the pipe
state per process.


