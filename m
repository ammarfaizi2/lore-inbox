Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263337AbTDOSrB (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 14:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263840AbTDOSrB 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 14:47:01 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:22790 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263337AbTDOSrB (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 14:47:01 -0400
Date: Tue, 15 Apr 2003 19:58:49 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Martin Schlemmer <azarah@gentoo.org>
cc: Krishnakumar B <kitty@cse.wustl.edu>, KML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: VT and VT_CONSOLE not present with menuconfig if INPUT=m  (was:
 2.5.67+ BK-current fails to boot on Athlon MP)
In-Reply-To: <1050130858.2754.77.camel@workshop.saharact.lan>
Message-ID: <Pine.LNX.4.44.0304151951100.8236-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But this brings me to the main issue .. any reason why you need
> to have INPUT=y to be able to select CONFIG_VT and CONFIG_VT_CONSOLE ?
> If INPUT=m for instance, it is not present ...

The VT system totally depends on the input api now. Previously you could 
build the VT system without selecting CONFIG_INPUT at all. Of course this 
caused build issues. As for selecting the input layer as a module you had 
the issue of booting but not having a usable keyboard. Makes it a 
challenge to type insmod input.o. Someday I plan to make the VT system 
modular (useful for embedded systems). 

> Won't it be better to make CONFIG_INPUT a bool (only y or n), as with
> this setup, you can still compile the other input drivers as modules ..

For embedded systems you don't really need the VT console. The type build 
will be serial console, input api and fbdev. No need for a VT console. 
On these devices you have serious constrants. So having the inout layer 
modular is a plus.


