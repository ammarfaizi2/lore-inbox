Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275083AbTHGCOr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 22:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275084AbTHGCOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 22:14:47 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:2576 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S275083AbTHGCOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 22:14:43 -0400
Message-Id: <5.1.0.14.2.20030807121131.03f21e90@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 07 Aug 2003 12:14:34 +1000
To: Andy Isaacson <adi@hexapodia.org>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: TOE brain dump
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030806120145.A15543@hexapodia.org>
References: <3F312C65.9000201@nortelnetworks.com>
 <3F2C0C44.6020002@pobox.com>
 <20030802184901.G5798@almesberger.net>
 <m1fzkiwnru.fsf@frodo.biederman.org>
 <20030804162433.L5798@almesberger.net>
 <m1u18wuinm.fsf@frodo.biederman.org>
 <20030806021304.E5798@almesberger.net>
 <m1llu7ushr.fsf@frodo.biederman.org>
 <20030806103758.H5798@almesberger.net>
 <20030806105830.B26920@hexapodia.org>
 <3F312C65.9000201@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:01 AM 7/08/2003, Andy Isaacson wrote:
> > > Just to be clear, I am asking for an example of a Gigabit Ethernet
> > > switch that supports cut-through switching.  I contend that there is no
> > > such beast commercially available today.

i concur.
"cut-through" is generally marketing these days.

there are some switches in the marketplace today which do cut-through 
switching, but fall back to store-&-forward when:
  - there is congestion in a port (i.e. output port is busy; queue frame)
  - the sender & receiver are of mismatched speeds
  - the receiver initiates gig-e flowcontrol

note that "cut-through switching" means that you lose the ability of the 
switch to drop corrupted frames.  i.e. how can it check the ethernet crc32 
and validate it until its all been sent?  in short, it cannot.

in real-world traffic scenarios, there is very little real-world scenarios 
where cut-through actually occurs.


cheers,

lincoln.

