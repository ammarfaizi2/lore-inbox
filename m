Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbTDPNVb (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 09:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264357AbTDPNVb 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 09:21:31 -0400
Received: from siaag1ab.compuserve.com ([149.174.40.4]:15786 "EHLO
	siaag1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S264346AbTDPNV2 (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 09:21:28 -0400
Date: Wed, 16 Apr 2003 09:28:43 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Benefits from computing physical IDE disk geometry?
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-raid <linux-raid@vger.kernel.org>
Message-ID: <200304160932_MC3-1-34A9-3A79@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The way you would do a good "goodness" function, I guess,
> would be to search through all requests on the device, and return
> the minimum distance from the request you are running the query
> on. Do this for both queues, and insert the request into the
> queue with the smallest delta. I don't see much else doing any
> good.


  That would be perfect.  And like you say in a later message, they're
in a tree so it might actually work.  Then the read balance code
wouldn't need to do that calculation at all.

  How hard would this be to add?



> On the other hand, if you simply have a fifo after the RAID
> scheduler, the RAID scheduler itself knows where each disk's
> head will end up simply by tracking the value of the last
> sector it has submitted to the device. It also has the advantage
> that it doesn't have "high level" scheduling stuff below it
> ie. request deadline handling, elevator scheme, etc.
> 
> This gives the RAID scheduler more information, without
> taking any away from the high level scheduler AFAIKS.


 But then wouldn't you have to put all that into the RAID
scheduler?

--
 Chuck
