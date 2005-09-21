Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbVIUOzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbVIUOzY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 10:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbVIUOzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 10:55:24 -0400
Received: from amdext4.amd.com ([163.181.251.6]:37536 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1751039AbVIUOzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 10:55:23 -0400
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
From: "Ray Bryant" <raybry@mpdtxmail.amd.com>
To: "Daniel Jacobowitz" <dan@debian.org>
Subject: Re: [discuss] Re: [PATCH] x86-64: Fix bad assumption that
 dualcore cpus have synced TSCs
Date: Wed, 21 Sep 2005 10:15:08 -0500
User-Agent: KMail/1.8
cc: "john stultz" <johnstul@us.ibm.com>, "Andi Kleen" <ak@suse.de>,
       "Andrew Morton" <akpm@osdl.org>, "lkml" <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
References: <1127157404.3455.209.camel@cog.beaverton.ibm.com>
 <1127242785.11080.20.camel@cog.beaverton.ibm.com>
 <20050921040342.GA7175@nevyn.them.org>
In-Reply-To: <20050921040342.GA7175@nevyn.them.org>
MIME-Version: 1.0
Message-ID: <200509211015.09356.raybry@mpdtxmail.amd.com>
X-WSS-ID: 6F2FABB428G1800641-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 September 2005 23:03, Daniel Jacobowitz wrote:

>
> FYI, at least I have reproduced this without powernow loaded.

There are cases that we are aware of where the TSC will count slower while the 
processor is halted.    This can make TSC's get out of sync on dual cores.

I wonder if you can reproduce this problem while also running a pair of cpu 
bound tasks on your dual core box.   If you can't, then this is the culprit.

In general, however, on multisocket systems, you can't depend on TSC's being 
synchronized between sockets, so all of this is moot.   We just have to deal 
with it. 

-- 
Ray Bryant
AMD Performance Labs                   Austin, Tx
512-602-0038 (o)                 512-507-7807 (c)

