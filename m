Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVCABUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVCABUd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 20:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVCABUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 20:20:33 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:11205 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261177AbVCABUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 20:20:13 -0500
Subject: Re: swapper: page allocation failure. order:1, mode:0x20
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Robert Hancock <hancockr@shaw.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4223C121.6090904@shaw.ca>
References: <3CRTy-82M-27@gated-at.bofh.it>  <4223C121.6090904@shaw.ca>
Content-Type: text/plain
Message-Id: <1109640134.4229.15.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 01 Mar 2005 12:22:14 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2005-03-01 at 12:10, Robert Hancock wrote:
> Bernd Schubert wrote:
> Essentially the tg3 Ethernet driver is trying to allocate memory to 
> store a received packet, and is unable to do so. Since this is done 
> inside interrupt context, this allocation has to be serviced from 
> physical memory. Order 1 means it only wanted one page of memory, and 

Minor point, I know, but it's 2 pages of memory. If it couldn't get an
order zero page, that would be even greater hernia material!

Regards,

Nigel

> since that failed it looks like the system must have been awfully short 
> on available physical RAM.. it could be some kind of kernel memory leak 
> or VM issue, though this condition may not be entirely unexpected in 
> certain cases, like if the system has little physical RAM free at a 
> certain point and then a flood of network packets arrive.
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://softwaresuspend.berlios.de


