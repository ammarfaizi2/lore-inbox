Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261415AbREQMIK>; Thu, 17 May 2001 08:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261416AbREQMIA>; Thu, 17 May 2001 08:08:00 -0400
Received: from [195.180.174.169] ([195.180.174.169]:1408 "EHLO idun.neukum.org")
	by vger.kernel.org with ESMTP id <S261415AbREQMH4>;
	Thu, 17 May 2001 08:07:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Miles Lane <miles@megapathdsl.net>, Tim Jansen <tim@tjansen.de>
Subject: Re: LANANA: To Pending Device Number Registrants
Date: Thu, 17 May 2001 14:07:38 +0200
X-Mailer: KMail [version 1.2]
Cc: David Brownell <david-b@pacbell.net>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <047801c0dd95$231331e0$6800000a@brownell.org> <01051601562302.01000@cookie> <990079966.25105.1.camel@agate>
In-Reply-To: <990079966.25105.1.camel@agate>
MIME-Version: 1.0
Message-Id: <01051714073800.01598@idun>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since, as Alan mentioned, the lack of device serial numbers for USB mice
> and keyboards means that the only way to implement a relatively stable
> assignment of USB input devices to a quasi-multiuser system with
> multi-headed displays is by paying attention to USB topology, I would
> like us to explore any implementation that includes this support.  As
> Linus mentioned, this approach is unreliable, but it's all we have for
> these devices -- Topology can be disturbed by a variety of events
> (plugging a hub into a different host-controller port, etc).

For identifying this is probably the right approach. However identifying is 
not enough, as the ioctl discussion has shown. Capabilities are needed. How 
can the device registry provide that information ? If we register it together 
with the device, we might spend a lot of resources needlessly and can't deal 
with devices whose capabilities change dynamically.

In addition how do we export the information ? Proc ? Device nodes (bad for 
network devices) ?

	Regards
		Oliver
