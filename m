Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWBRMzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWBRMzo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWBRMzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:55:17 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:38811 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751239AbWBRMzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:55:07 -0500
Date: Fri, 17 Feb 2006 22:04:45 +0100
From: Pavel Machek <pavel@suse.cz>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Kyle Moffett <mrmacman_g4@mac.com>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
Message-ID: <20060217210445.GR3490@openzaurus.ucw.cz>
References: <Pine.LNX.4.44L0.0602131601220.4754-100000@iolanthe.rowland.org> <43F11A9D.5010301@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F11A9D.5010301@cfl.rr.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> >You are ignoring the question of how the kernel can tell whether two 
> >devices are in fact the same.  There is no safe way to do this, 
> >other than having the hardware verify that the device was connected 
> >the whole time.
> >
> >  
> If there is no better way to tell for sure that the device that is 
> now there is not the same as the one that was there, then the kernel 
> must assume the user did not do something stupid and continue to use 

Must?! Are you Linus or what?

> the device as if it was not disconnected ( because odds are, it in 
> fact, was not ).  In other words, which is more safe?  ALLWAYS 
> loosing data because you can't be absolutely sure that the device is 
> the same, or only loosing data if the user does something as foolish 
> as swapping drives while suspended, and you can't tell they did?

You are missing this. In 1st case, no data is actually lost, because of
sync in suspend code;
while second case is "goodbye, filesystem".
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

