Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbTFGOXA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 10:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTFGOXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 10:23:00 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:40851 "EHLO
	alpha.stev.org") by vger.kernel.org with ESMTP id S262984AbTFGOW6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 10:22:58 -0400
Date: Sat, 7 Jun 2003 16:36:39 +0100 (BST)
From: James Stevenson <james@stev.org>
To: chas williams <chas@cmf.nrl.navy.mil>
cc: Werner Almesberger <wa@almesberger.net>,
       "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2) 
In-Reply-To: <200306071121.h57BL4sG006740@ginger.cmf.nrl.navy.mil>
Message-ID: <Pine.LNX.4.44.0306071634540.1776-100000@jlap.stev.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In message <Pine.LNX.4.44.0306071214110.19033-100000@god.stev.org>,James Steven
> son writes:
> >Think of a latop with a normall ethernet card in it.
> >When you unplug the cable it wont disconnect all the tcp
> >connection on the interface so that you could re route everything though
> >a wireless card.
> 
> if i have a single interface and i physically remove it (not just unplug
> the cable)  i would be willing to accept that certain tcp connections are
> going to die.  particularly tcp which might be using keep alives.

>From how is understand it the tcp connections should be alive
until they try to send data. As soon as they try to send
data on a down interface as in they dont have a route any more
an icmp packet of host / network unreachable should be generated
then the connection can be killed.

	James

