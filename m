Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbTJFPdM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 11:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbTJFPdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 11:33:12 -0400
Received: from ltgp.iram.es ([150.214.224.138]:24972 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S262282AbTJFPdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 11:33:09 -0400
From: Gabriel Paubert <paubert@iram.es>
Date: Mon, 6 Oct 2003 17:26:32 +0200
To: Hans-Georg Thien <1682-600@onlinehome.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: getting timestamp of last interrupt?
Message-ID: <20031006152632.GA3419@iram.es>
References: <fa.fj0euih.s2sbop@ifi.uio.no> <fa.ch95hks.10kepak@ifi.uio.no> <3F7E46EE.1020201@onlinehome.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F7E46EE.1020201@onlinehome.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 04, 2003 at 06:05:02AM +0200, Hans-Georg Thien wrote:
> Karim Yaghmour wrote:
> 
> >
> >Hans-Georg Thien wrote:
> >
> >>I am looking for a possibility to read out the last timestamp when an 
> >>interrupt has occured.
> >>
> >>e.g.: the user presses a key on the keyboard. Where can I read out the 
> >>timestamp of this event?
> >>
> >>To be more precise, I 'm looking for
> >>
> >>( )a function call
> >>( ) a callback where I can register to be notified when an event occurs
> >>( ) a global accessible variable
> >>( ) a /proc entry
> >>
> >>or something like that.
> >>
> >>Any ideas ?
> >
> >
> >Have a look at the Linux Trace Toolkit:
> >http://www.opersys.com/LTT/
> >It records micro-second time-stamps for quite a few events, including
> >interrupts.
> >
> thanke a lot for reply Karim,
> 
> but I think that LTT does not fit to my needs. It needs to modify the
> kernel - and that is what I want to avoid.
> 
> I'm looking for a already existing built-in capability.
> 
> Maybe signal SIGIO is a solution, if it  does not
> 
> (x) give me *every* IO event
> (x) has to much overhead - I have to respond to keyboard/mouse events, *not*

Doesn't the input layer add a timestamp to every event? 

At least that's the impression I have from xxd /dev/input/eventN: the
first eight bytes of each 16 bytes packet look so furiously close to
a struct timeval that they can't be anything else :-)

Just that I don't know how the devices and N are associated, it seems to be
order of discovery/registering at boot.

	Regards,
	Gabriel
