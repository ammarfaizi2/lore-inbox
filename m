Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265584AbTFMXna (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 19:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265585AbTFMXn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 19:43:29 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:50439 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265584AbTFMXn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 19:43:28 -0400
Date: Sat, 14 Jun 2003 00:57:14 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Vojtech Pavlik <vojtech@ucw.cz>
cc: Peter Berg Larsen <pebl@math.ku.dk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
In-Reply-To: <20030614000857.B10851@ucw.cz>
Message-ID: <Pine.LNX.4.44.0306140045160.29353-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > Just as a idea for API. How about ABS_AREA or REL_AREA instead of 
> > > > ABS_MISC. The idea is the pressure value returned should be about 
> > > > the same if one presses hard with one finger or softly with a whole 
> > > > hand.
> > > 
> > > Huh? Force = Pressure x Area ... I think you're mixing up force and
> > > pressure here.
> > 
> > OOps. Your right. I'm thinking the hardware returns a force value. What I 
> > meant is since we have the hardware returning the pressure and the area 
> > this data can be used. Knowing the area over which a pressure is applied 
> > is a good thing. What do you think?
> 
> Definitely. Still it doesn't cover the multi-tap/gesture stuff.

How about EV_AREA
codes = "which area"  1, 2, 3
value = "How big of a area" 

struct input_event {
        struct timeval time;
        __u16 type;               EV_AREA
        __u16 code;	          AREA_1
        __s32 value;		  20
};



