Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbUK0ESn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbUK0ESn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbUK0EOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 23:14:18 -0500
Received: from lucidpixels.com ([66.45.37.187]:42725 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S262110AbUKZTNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:13:55 -0500
Date: Fri, 26 Nov 2004 07:07:12 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: Robert Olsson <Robert.Olsson@data.slu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TULIP_NAPI_HW_MITIGATION latency question.
In-Reply-To: <16806.1163.601015.670054@robur.slu.se>
Message-ID: <Pine.LNX.4.61.0411260707100.19733@p500>
References: <Pine.LNX.4.61.0411231242090.3740@p500> <16806.1163.601015.670054@robur.slu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the info.

On Thu, 25 Nov 2004, Robert Olsson wrote:

>
>
>
> Justin Piszcz writes:
> > "at the cost of a small latency"
> >
> > How much additional latency is added with this option enabled?
> >
> > 5ms? 10ms?
> >
> > -> Use Interrupt Mitigation
> >    x CONFIG_TULIP_NAPI_HW_MITIGATION:
> >    x Use HW to reduce RX interrupts. Not strict necessary since NAPI
> > reduces RX interrupts but itself. Although this reduces RX interrupts even at
> > low levels traffic at the cost of a small latency.
> > x
> >    x If in doubt, say Y.
>
> Hello!
>
> It's in usec and the tulip only enables this latency when it's needed it
> really tries to keep latency down.
>
> It has three steeps of input control.
>
> Low rate:     No driver latency. No interrupt delay at all.
> Medium rate:  Samll driver latency.
> High rate:    Polling via ->poll
>
> 						--ro
>
