Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWCaUGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWCaUGW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 15:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWCaUGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 15:06:21 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:19744 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S932270AbWCaUGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 15:06:20 -0500
In-Reply-To: <c0a09e5c0603311204k6b64842bm741d3e7726b39e77@mail.gmail.com>
References: <20060329225505.25585.30392.stgit@gitlost.site> <c0a09e5c0603301036s4e9a63e5v476d89ff8ba37760@mail.gmail.com> <351C5BDA-D7E3-4257-B07E-ABDDCF254954@kernel.crashing.org> <200603311026.33391.netdev@axxeo.de> <c0a09e5c0603311204k6b64842bm741d3e7726b39e77@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C46414E1-3A15-48CF-86F9-4D1D219DC1E7@kernel.crashing.org>
Cc: "Ingo Oeser" <netdev@axxeo.de>,
       "Chris Leech" <christopher.leech@intel.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/9] [I/OAT] DMA memcpy subsystem
Date: Fri, 31 Mar 2006 14:06:29 -0600
To: "Andrew Grover" <andy.grover@gmail.com>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 31, 2006, at 2:04 PM, Andrew Grover wrote:

> On 3/31/06, Ingo Oeser <netdev@axxeo.de> wrote:
>> Kumar Gala wrote:
>>> Fair, but wouldn't it be better to have the association per client.
>>>
>>> Maybe leave the one as a summary and have a dir per client with
>>> similar stats that are for each client and add a per channel summary
>>> at the top level as well.
>> Such level of detail really belongs to debugging, IMHO.
> [snip]
>
> If we implemented more stats then yes debugfs sounds like it might be
> the way to go.
>
>> BTW: What is the actual frequency, at which such counters
>> will be incremented?
>
> Currently the code updates these variables (kept per cpu) every time a
> copy is queued. See include/linux/dmaengine.h.

Might it be better to update when the transfer is done incase of an  
error?

- kumar

