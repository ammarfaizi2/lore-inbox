Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267174AbTB0WMK>; Thu, 27 Feb 2003 17:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267153AbTB0WMJ>; Thu, 27 Feb 2003 17:12:09 -0500
Received: from alpha6.its.monash.edu.au ([130.194.1.25]:28937 "EHLO
	ALPHA6.ITS.MONASH.EDU.AU") by vger.kernel.org with ESMTP
	id <S267126AbTB0WMH>; Thu, 27 Feb 2003 17:12:07 -0500
Date: Fri, 28 Feb 2003 09:21:38 +1100
From: Greg Daley <greg.daley@eng.monash.edu.au>
Subject: Re: anyone ever done multicast AF_UNIX sockets?
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       linux-net@vger.kernel.org
Reply-to: greg.daley@eng.monash.edu.au
Message-id: <3E5E8F72.2080206@eng.monash.edu.au>
Organization: Monash University
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en, en-us
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
References: <3E5E7081.6020704@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

Please check out the uml_switch
written by jeff dike for Mser Mode Linux.

It is a user-space program which emultates
an ethernet switch (or hub).  It emulates
link-layer multicast on UNIX domain sockets.

Greg Daley

Chris Friesen wrote:
> 
> It is fairly common to want to distribute information between a single 
> sender and multiple receivers on a single box.
> 
> Multicast IP sockets are one possibility, but then you have additional 
> overhead in the IP stack.
> 
> Unix sockets are more efficient and give notification if the listener is 
> not present, but the problem then becomes that you must do one syscall 
> for each listener.
> 
> So, here's my main point--has anyone ever considered the concept of 
> multicast AF_UNIX sockets?
> 
> The main features would be:
> --ability to associate/disassociate a socket with a multicast address
> --ability to associate/disassociate with all multicast addresses 
> (possibly through some kind of raw socket thing, or maybe a simple 
> wildcard multicast address)
> --on process death all sockets owned by that process are disassociated 
> from any multicast addresses that they were associated with
> --on sending a packet to a multicast address and there are no sockets 
> associated with it, return -1 with errno=ECONNREFUSED
> 
> The association/disassociation could be done using the setsockopt() 
> calls the same as with udp sockets, everything else would be the same 
> from a userspace perspective.
> 
> Any thoughts?  How hard would this be to put in?
> 
> Chris
> 
> 


