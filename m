Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264190AbTKNRFh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 12:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264525AbTKNRFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 12:05:36 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:31951 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S264190AbTKNREt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 12:04:49 -0500
Message-ID: <3FB50CB9.9050702@pacbell.net>
Date: Fri, 14 Nov 2003 09:11:21 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>,
       =?ISO-8859-1?Q?Rog=E9rio_Br?= =?ISO-8859-1?Q?ito?= 
	<rbrito@ime.usp.br>
CC: linux-usb-devel@lists.sourceforge.net,
       linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [BUG] Still having problems with an USB Drive
References: <Pine.LNX.4.44L0.0311141045000.1063-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0311141045000.1063-100000@ida.rowland.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> On Thu, 13 Nov 2003, Rogério Brito wrote:
> 
> 
>>Yes, thinking more about the problem, that seems to be the case. David
>>Brownell already told me that.
>>
>>I sent him an e-mail telling what I see when I modify my
>>/etc/hotplug/usb.rc script to contain "modprobe -q uhci-hcd debug=2".

He never got it, and the webpages you put up with that info didn't
have that information either.  Please just keep the list updated;
I don't have much time for such things.

And for that matter, all followups _only_ to linux-usb-devel please!
This discussion shouldn't be CC'd to three large lists (IMO).



>>>	hub 2-2.2:1.0: transfer --> -75
>>>
>>>indicates a problem with the internal hub, but there's no way to tell what 
>>>that problem is.  The other error message
>>
>>Is there any way to discover what may be the reason of the problem? Any
>>higher debugging level would help with that?

The message only comes out in one place (drivers/usb/core/hub.c),
so there's only one way it could appear...

Clearly this external hub is misbehaving, that should never happen.
Maybe it needs more power than it's getting.

However, even if the hub driver does see a fault, that's no excuse
for khubd to lock up.

- Dave


