Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261515AbREUStq>; Mon, 21 May 2001 14:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261399AbREUStg>; Mon, 21 May 2001 14:49:36 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:39384 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261397AbREUSt0>;
	Mon, 21 May 2001 14:49:26 -0400
Date: Mon, 21 May 2001 14:49:23 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Oliver Xymoron <oxymoron@waste.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending DeviceNum
In-Reply-To: <Pine.LNX.4.30.0105211322580.17263-100000@waste.org>
Message-ID: <Pine.GSO.4.21.0105211437040.12245-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 May 2001, Oliver Xymoron wrote:

> K - so what? I'm guessing what you want me to see is that these
> implement multiple channels. Is there a reason that eia001stat couldn't be
> implemented as
> 
>  f=open("/dev/eia001ctl",O_RDWR);
>  write(f,"stat\n");
>  status=read(f); /* returns "stat foo\n" */

Less convenient.

> We don't want to implement a separate device node for every OOB ioctl that
> returns data, do we? Why should stat be any different?

For every? Probably not. Forcing all of them together? I bet that in many
cases it will be damn inconvenient. You are forcing the policy on all
drivers. For no good reason, AFAICS.

> /dev/draw is interesting but largely irrelevant. And again, colormap and
> refresh - why are they not part of ctl? You've got to select on refresh
> anyway, might as well accept asynchronous messages through ctl.

You've got to do _what_ on refresh?

