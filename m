Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264927AbTLFCSL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 21:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbTLFCSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 21:18:11 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:47000 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id S264927AbTLFCSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 21:18:10 -0500
Date: Fri, 5 Dec 2003 21:16:12 -0500 (EST)
From: Mike Gorse <mgorse@mgorse.dhs.org>
To: Greg KH <greg@kroah.com>
cc: Maneesh Soni <maneesh@in.ibm.com>, linux-kernel@vger.kernel.org,
       mochel@digitalimplant.org
Subject: Re: Oops w/sysfs when closing a disconnected usb serial device
In-Reply-To: <20031206013844.GA16844@kroah.com>
Message-ID: <Pine.LNX.4.58.0312052102460.13792@mgorse.dhs.org>
References: <Pine.LNX.4.58.0311301900110.32493@mgorse.dhs.org>
 <20031201093804.GA6918@in.ibm.com> <Pine.LNX.4.58.0312011849050.9617@mgorse.dhs.org>
 <20031206013844.GA16844@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Dec 2003, Greg KH wrote:

> Try the patch below.  With your sysfs patch I don't get any oopses
> anymore.  I still need to beat on this patch a lot more before I think
> it solves all of the current issues.  Can you let me know if it works
> for you or not?
> 
I tried it briefly, and it made no difference with the issue I am having.  
When disconnecting the gps receiver with a fd still open on it, it still 
gives an oops on closing it without the sysfs patch.  The sysfs patch 
eliminates the oops, but I wasn't getting an oops without your patch if I 
include the sysfs patch.  Anyway, I have over 200k of debugging output, so 
I'll send it to you off list.

Thanks,
-Mike G
