Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264281AbTFPW2N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 18:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264376AbTFPW2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 18:28:13 -0400
Received: from air-2.osdl.org ([65.172.181.6]:176 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264281AbTFPW2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 18:28:12 -0400
Date: Mon, 16 Jun 2003 15:43:56 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Alan Stern <stern@rowland.harvard.edu>
cc: Russell King <rmk@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
In-Reply-To: <Pine.LNX.4.44L0.0306161714100.789-100000@ida.rowland.org>
Message-ID: <Pine.LNX.4.44.0306161540110.908-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Are you sure?  Suppose a pcmcia disk drive is plugged in to that socket.  
> Why is a disk driver going to name its object "pcmcia_socket0"?  It must
> be the pcmcia socket driver that owns the object, not the disk driver.  So 
> then where does the disk driver put the disk-related attributes?  Don't 
> say in /sys/class/pcmcia_socket/pcmcia_socket0/device/, because the driver 
> doesn't own that object either.

Well, are you talking about a socket or a disk? Obviously, those are very 
different devices, and hence have very different objects that you create 
for them. 

One way or another, you should be exporting attributes under the directory 
of the object that you create. If it's a socket, put it under the socket 
directory above. If it's a disk, then it will have a directory in another 
location for which you can export attributes. 

Do you have a specific example, or are you just hypothesizing? 


	-pat

