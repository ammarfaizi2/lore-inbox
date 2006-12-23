Return-Path: <linux-kernel-owner+w=401wt.eu-S1751839AbWLWDCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbWLWDCK (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 22:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752581AbWLWDCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 22:02:10 -0500
Received: from que03.charter.net ([209.225.8.191]:34989 "EHLO
	que03.charter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbWLWDCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 22:02:08 -0500
Message-ID: <458C97ED.4000904@cybsft.com>
Date: Fri, 22 Dec 2006 20:43:57 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: "Chen, Tim C" <tim.c.chen@intel.com>
CC: mingo@elte.hu, linux-kernel@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: 2.6.19-rt14 slowdown compared to 2.6.19
References: <9D2C22909C6E774EBFB8B5583AE5291C0199950A@fmsmsx414.amr.corp.intel.com>
In-Reply-To: <9D2C22909C6E774EBFB8B5583AE5291C0199950A@fmsmsx414.amr.corp.intel.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Chzlrs: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Tim C wrote:
> Ingo,
>  
> We did some benchmarking on 2.6.19-rt14, compared it with 2.6.19 
> kernel and noticed several slowdowns.  The test machine is a 2 socket
> woodcrest machine with your default configuration.
>  
> Netperf TCP Streaming was slower by 40% ( 1 server and 1 client 
> each bound to separate cpu cores on different socket, network
> loopback mode was used).  
> 
> Volanomark was slower by 80% (Server and Clients communicate with 
> network loopback mode. Idle time goes from 1% to 60%)
> 
> Re-Aim7 was slower by 40% (idle time goes from 0% to 20%)
> 
> Wonder if you have any suggestions on what could cause the slowdown.  
> We've tried disabling CONFIG_NO_HZ and it didn't help much.
>
> Thanks.
> 
> Tim

Take a look at this. Not sure if this is the same problem but it looks
like a candidate. I can definitely say that some latencies I have seen
in my recent testing have gone away in the last few versions
2.6.20-rc1-rt{3,4}.

-- 
	kr
