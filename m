Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263350AbTDSE7T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 00:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263353AbTDSE7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 00:59:19 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:16104 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S263350AbTDSE7S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 00:59:18 -0400
Message-ID: <3EA0CD95.1070109@pacbell.net>
Date: Fri, 18 Apr 2003 21:16:21 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: "Kevin P. Fleming" <kpfleming@cox.net>
CC: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
References: <20030411172011.GA1821@kroah.com> <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin P. Fleming wrote:
> 
> 	 All it takes 
> for the driver for a Fibre Channel host adapter to load, and enumerate 
> the devices it can see. In a matter of seconds many hundreds or 
> thousands of disk devices could be registered with the kernel.

Not the design center for the original "exec /sbin/hotplug" style
event delivery, no way!

A near-term option would be just to have some kind of throttle on
how many hotplug invocations are going on concurrently -- avoiding
process creation storms.  That should easily take Linux all the way
into the 2.7 series, for those who want to tread carefully in terms
of changing sysadmin technologies.

- Dave



