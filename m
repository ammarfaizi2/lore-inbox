Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268893AbTGOQPr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 12:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268822AbTGOQOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 12:14:55 -0400
Received: from sea2-f43.sea2.hotmail.com ([207.68.165.43]:4625 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S268730AbTGOQNU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 12:13:20 -0400
X-Originating-IP: [143.182.124.2]
X-Originating-Email: [dagriego@hotmail.com]
From: "David griego" <dagriego@hotmail.com>
To: davem@redhat.com, jros@xiran.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com, alan@storlinksemi.com
Subject: Re: TCP IP Offloading Interface
Date: Tue, 15 Jul 2003 09:28:10 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F43cOV1EetVoMD0001d71a@hotmail.com>
X-OriginalArrivalTime: 15 Jul 2003 16:28:10.0676 (UTC) FILETIME=[14B7AF40:01C34AEE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok I've taken a look at your scheme and I have a few questions.

>From: "David S. Miller" <davem@redhat.com>
>You also ignore the points others have made that the systems HAVE
>SCALED to evolving networks technologies as they have become faster
>and faster.
>
This is not true in the embedded space.  As I keep pointing out  typical 
embedded processors don't have as many free cycles as server computers.
>
>
>My RX receive page accumulation scheme handles all of the
>receive side problems with touching the data and getting
>into the filesystem and then the device.  With my scheme
>you can receive the data, go direct to the device, and the
>cpu never touches one byte.
>
RDDP tries to get around needing a large amount of RAM on the NIC to collect 
all of this data before writing it to the OS memory.  Also, this store and 
forward architecture you recommend adds latency in collecting all of this 
data before moving it to the OS.  Finally, I recall some resistance to page 
flipping which could also lead to walking page tables.  More latency.  After 
some extremely large amount of time your receive data has made it to your 
application.  Do you have a suggestion on how we could get around all of 
this store and forward without RDDP?  Just avoiding the CPU copy is not the 
only issue.
>
>I actually welcome Microsoft falling into this rathole of a
>technology.  Let them have to support that crap and have to field bug
>reports on it, having to wonder who created the packets.  And let them
>deal with the negative effects TOE has on connection rates and things
>like that.
>
Would it be shame if they found away around this "problem" you see and are 
successful and Linux failed because you felt the community is not able 
overcome these though obstacles?
>
>Linux will be competitive, especially if people develop the scheme I
>have described several times into the hardware.  There are vendors
>doing this, will you choose to be different and ignore this?
Your ideas are good, but they leave in this store and forward issue that I 
mentioned.  A good alternative would be one that kept things simple as you 
suggested, but didn't introduce all of this latency.

_________________________________________________________________
The new MSN 8: smart spam protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail

