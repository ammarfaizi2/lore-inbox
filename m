Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbVJYHll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbVJYHll (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 03:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbVJYHll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 03:41:41 -0400
Received: from ns2.suse.de ([195.135.220.15]:50144 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932066AbVJYHll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 03:41:41 -0400
From: Andi Kleen <ak@suse.de>
To: Jonas Oreland <jonas@mysql.com>
Subject: Re: x86-64: Syncing dualcore cpus TSCs
Date: Tue, 25 Oct 2005 09:42:25 +0200
User-Agent: KMail/1.8
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, discuss@x86-64.org
References: <1127157404.3455.209.camel@cog.beaverton.ibm.com> <434BE7E9.8000501@mysql.com> <435DE042.9060208@mysql.com>
In-Reply-To: <435DE042.9060208@mysql.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510250942.25973.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 October 2005 09:35, Jonas Oreland wrote:
> Hi,
>
> This might be a very bad suggestion, but here it is:
>
> On dualcore cpus (amd64) the TSC will get out of sync when executing hlt
> instruction. booting with idle=poll, will make it never to execute hlt,
> hence TSC will be in sync. booting with notsc will make it use other time
> source...but this is slower (this is default after "[PATCH] x86-64: Fix bad
> assumption that dualcore cpus have synced TSCs")
>
> How about syncing TSC after hlt?
>
> If cost of syncing TSC's is smaller than cost of using other time source
> this might be an alternative.

I very doubt it is. Syncing TSCs requires stopping multiple CPUs for longer 
time. It is unlikely you can make that up.

-Andi
