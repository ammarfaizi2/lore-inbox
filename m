Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161115AbWJNLaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161115AbWJNLaN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 07:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161114AbWJNLaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 07:30:13 -0400
Received: from bay0-omc2-s12.bay0.hotmail.com ([65.54.246.148]:27028 "EHLO
	bay0-omc2-s12.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1752168AbWJNLaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 07:30:12 -0400
Message-ID: <BAY20-F2629AFC1128150E2482D6D80B0@phx.gbl>
X-Originating-IP: [80.178.73.98]
X-Originating-Email: [yan_952@hotmail.com]
In-Reply-To: <20061014082608.GA3851@elf.ucw.cz>
From: "Burman Yan" <yan_952@hotmail.com>
To: pavel@ucw.cz
Cc: kronos.it@gmail.com, linux-kernel@vger.kernel.org
Subject: RE: HP disk protection Re: Remn Yan <yan_952@hotmail.com> ha scritto:
Date: Sat, 14 Oct 2006 13:30:10 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 14 Oct 2006 11:30:11.0565 (UTC) FILETIME=[1C4519D0:01C6EF84]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




>From: Pavel Machek <pavel@ucw.cz>
>To: Burman Yan <yan_952@hotmail.com>
>CC: kronos.it@gmail.com, linux-kernel@vger.kernel.org
>Subject: HP disk protection Re: Remn Yan <yan_952@hotmail.com> ha scritto:
>Date: Sat, 14 Oct 2006 10:26:08 +0200
>
>On Fri 2006-10-13 20:32:48, Burman Yan wrote:
> > >From: Luca Tettamanti <kronos.it@gmail.com>
>
> > >Burman Yan <yan_952@hotmail.com> ha scritto:
> > >> I would like to hear your remarks on this version.
> > >
> > >> +static ssize_t mdps_calibrate_store(struct device *dev,
> > >> +                   struct device_attribute *attr, const char *buf,
> > >size_t count)
> > >> +{
> > >> +	mdps_calibrate_mouse();
> > >> +	return count;
> > >> +}
> > >
> > >No locking here?
> >
> > I don't want to lock it here, since the mouse polling kthread is heavy 
>as
> > it is.
>
> > I'd rather report a wrong value of mouse position while recalibrating.
> > The way I see it, if you're recalibrating your mouse, chances are you're
> > not playing at the same precise millisecond. In my opinion it's worth 
>more
> > battery life.
>
>Hmm, and are you sure it can't oops or something?

Well, other than in calibrate, I use it only in one other place - the mouse 
polling kthread
(mdps_mouse_kthread). In there it's used to calculate the absolute location 
of the "mouse".
At most I will get a value that doesn not correspond to the current 
position.
This means that the mouse pointer will perhaps jump, since the x calibration 
value has
updated and y calibration has not yet.

Yan

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar - get it now! 
http://toolbar.msn.click-url.com/go/onm00200415ave/direct/01/

