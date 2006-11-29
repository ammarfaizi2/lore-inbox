Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967676AbWK2XgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967676AbWK2XgR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 18:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967460AbWK2XgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 18:36:17 -0500
Received: from dvhart.com ([64.146.134.43]:7369 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S967420AbWK2XgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 18:36:15 -0500
Message-ID: <456E196E.2080802@mbligh.org>
Date: Wed, 29 Nov 2006 15:36:14 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: wenji@fnal.gov
Cc: netdev@vger.kernel.org, davem@davemloft.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Changelog] - Potential performance bottleneck for Linxu TCP
References: <HNEBLGGMEGLPMPPDOPMGCEAKCGAA.wenji@fnal.gov>
In-Reply-To: <HNEBLGGMEGLPMPPDOPMGCEAKCGAA.wenji@fnal.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wenji Wu wrote:
> From: Wenji Wu <wenji@fnal.gov>
> 
> Greetings,
> 
> For Linux TCP, when the network applcaiton make system call to move data
> from
> socket's receive buffer to user space by calling tcp_recvmsg(). The socket
> will
> be locked. During the period, all the incoming packet for the TCP socket
> will go
> to the backlog queue without being TCP processed. Since Linux 2.6 can be
> inerrupted mid-task, if the network application expires, and moved to the
> expired array with the socket locked, all the packets within the backlog
> queue
> will not be TCP processed till the network applicaton resume its execution.
> If
> the system is heavily loaded, TCP can easily RTO in the Sender Side.


So how much difference did this patch actually make, and to what
benchmark?

> The patch is for Linux kernel 2.6.14 Deskop and Low-latency Desktop

The patch oesn't seem to be attached? Also, would be better to make
it for the latest kernel version (2.6.19) ... 2.6.14 is rather old ;-)

M
