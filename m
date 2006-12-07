Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163438AbWLGVsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163438AbWLGVsV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 16:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163455AbWLGVsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 16:48:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48842 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163438AbWLGVsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 16:48:19 -0500
Message-ID: <45788BF8.2010908@redhat.com>
Date: Thu, 07 Dec 2006 16:47:36 -0500
From: Chris Lalancette <clalance@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Horman <nhorman@tuxdriver.com>
CC: linux-net@vger.kernel.org, mpm@selenic.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netpoll: make arp replies through netpoll use mac address
 of sender
References: <20061207194553.GB29313@hmsreliant.homelinux.net>
In-Reply-To: <20061207194553.GB29313@hmsreliant.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Horman wrote:
> Back in 2.4 arp requests that were recevied by netpoll were processed in
> netconsole_receive_skb, where they were responded to using the src mac of the
> request sender.  In the 2.6 kernel arp_reply is responsible for this function,
> but instead of using the src mac address of the incomming request, the stored
> mac address that was registered for the netconsole application is used.  While
> this is usually ok, it can lead to failures in netpoll in some situations
> (specifically situations where a network may have two gateways, as arp requests
> from one may be responded to using the mac address of the other).  This patch
> reverts the behavior to what we had in 2.4, in which all arp requests are sent
> back using the src address of the request sender.
> 
> Thanks & Regards
> Neil
> 
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> 

Neil and I worked on this together, adding my ACK

Acked-by: Chris Lalancette <clalance@redhat.com>
