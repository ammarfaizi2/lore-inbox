Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262828AbSJJCpV>; Wed, 9 Oct 2002 22:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262841AbSJJCpV>; Wed, 9 Oct 2002 22:45:21 -0400
Received: from mnh-1-27.mv.com ([207.22.10.59]:23557 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S262828AbSJJCpU>;
	Wed, 9 Oct 2002 22:45:20 -0400
Message-Id: <200210100355.WAA06063@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Dan Kegel <dank@kegel.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] High-res-timers part 2 (x86 platform code) take 5.1 
In-Reply-To: Your message of "Wed, 09 Oct 2002 17:50:30 MST."
             <3DA4CED6.1BD30A2F@kegel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 09 Oct 2002 22:55:52 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dank@kegel.com said:
> George's approach would work a lot better when doing lots of UML VM's
> on a single box, too, wouldn't it? 

My thinking on this is that I'll have UML do the on-demand ticks.  So, on
a host with n UMLs, we will no longer have n * HZ timer deliveries/sec.

I haven't thought a lot about it, but this seems largely unconnected to how 
the host does its timers.

The one connection I can think of is that any generic support for on-demand
ticks would be re-used by UML.  And if UML required generic changes for this,
then that would obviously affect the other ports somehow.

				Jeff

