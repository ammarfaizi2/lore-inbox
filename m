Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262233AbVBKHjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbVBKHjy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 02:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbVBKHjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 02:39:08 -0500
Received: from conn.mc.mpls.visi.com ([208.42.156.2]:27565 "EHLO
	conn.mc.mpls.visi.com") by vger.kernel.org with ESMTP
	id S262215AbVBKHHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 02:07:10 -0500
Message-ID: <1108105628.420c599cf3558@my.visi.com>
Date: Fri, 11 Feb 2005 01:07:08 -0600
From: Al Borchers <alborchers@steinerpoint.com>
To: nacc@us.ibm.com
Cc: david-b@pacbell.net, greg@kroah.com, linux-kernel@vger.kernel.org,
       alborchers@steinerpoint.com
Subject: Re: [RFC PATCH] add wait_event_*_lock() functions
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 67.180.173.167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday 10 February 2005 9:39 am, Nishanth Aravamudan wrote:
>> It came up on IRC that the wait_cond*() functions from
>> usb/serial/gadget.c could be useful in other parts of the kernel. Does
>> the following patch make sense towards this?

Sure, if people want to use these.

I did not push them because they seemed a bit "heavy weight",
but the construct is useful and general.

The docs should explain that the purpose is to wait atomically on
a complex condition, and that the usage pattern is to hold the
lock when using the wait_event_* functions or when changing any
variable that might affect the condition and waking up the waiting
processes.

-- Al
