Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263555AbUECCpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbUECCpt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 22:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbUECCpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 22:45:49 -0400
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:48324 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S263555AbUECCpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 22:45:46 -0400
Message-ID: <4095B25D.2020607@backtobasicsmgmt.com>
Date: Sun, 02 May 2004 19:45:49 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back To Basics Network Management
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Hernberg <petehern@yahoo.com>
CC: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Implementing an "on demand" routing protocol?
References: <1083549369.613.23.camel@mine>
In-Reply-To: <1083549369.613.23.camel@mine>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Hernberg wrote:

> Is there an interface whereby the kernel can be told "when you have a
> packet, but lack a route to its destination, pass a message to this
> daemon requesting a route and buffer that packet until the daemon is
> done searching for route"? Any info would be appreciated.

A starting point might be a daemon that listens on a tun interface, with 
that interface being the target of a "default" route. The daemon can 
then receive the packets, do what it likes with them, add routes to the 
routing table, then reinject the packets back into the tun interface 
once the route is in place.
