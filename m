Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264090AbUDVOlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264090AbUDVOlq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 10:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUDVOlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 10:41:46 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:30994 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264083AbUDVOlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 10:41:02 -0400
Message-ID: <4087DA1D.8050106@techsource.com>
Date: Thu, 22 Apr 2004 10:43:41 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Jan De Luyck <lkml@kcore.org>
CC: linux-kernel@vger.kernel.org, Joel Jaeggli <joelja@darkwing.uoregon.edu>
Subject: Re: System hang with ATI's lousy driver
References: <Pine.LNX.4.44.0404201216280.10469-100000@twin.uoregon.edu> <200404220718.40070.lkml@kcore.org>
In-Reply-To: <200404220718.40070.lkml@kcore.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jan De Luyck wrote:
> On Tuesday 20 April 2004 21:28, Joel Jaeggli wrote:
> 
> 
>>kernel drm + xfree86 driver will actually provide accelerated opengl
>>support in Xwindows albiet without quite as many hardware features as the
>>proprietary driver on all the rv2xx chipsets including the 9000 but not
>>on the later models.
>>
>>kernel drm & radeonfb have been reported to not play very well with each
>>other in other venues. vesafb is known to work in this situation though.
> 
> 
> I have that particular setup running quite satisfactory now for a few months, 
> using a Radeon 9000 Mobile chip. No problems at all.
> 


I discovered why I thought the Mesa driver wasn't working.  It turns out 
that kscreensaver is broken.  If I use xscreensaver, or the screen saver 
starts from Gnome, or I run the OpenGL program stand-alone, everything 
works fine.  But if I use KDE's screen saver program or it starts 
automatically in KDE, OpenGL screen savers get all flickery, as if 
double-buffering had been disabled.

Apparently, this is a long out-standing bug in KDE.


The only bit of this that is not off-topic is that ATI's proprietary 
drivers are broken, because they don't get along with radeonfb.

