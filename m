Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266076AbTIEUbT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 16:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266036AbTIEUbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 16:31:16 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:29895 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266076AbTIEUa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 16:30:27 -0400
Date: Fri, 05 Sep 2003 13:19:24 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy v12
Message-ID: <207340000.1062793164@flay>
In-Reply-To: <20030905202232.GD19041@matchmail.com>
References: <3F58CE6D.2040000@cyberone.com.au> <195560000.1062788044@flay> <20030905202232.GD19041@matchmail.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Sep 05, 2003 at 11:54:04AM -0700, Martin J. Bligh wrote:
>> > Backboost is gone so X really should be at -10 or even higher.
>> 
>> Wasn't that causing half the problems originally? Boosting X seemed
>> to starve xmms et al. Or do the interactivity changes fix xmms
>> somehow, but not X itself? Explicitly fiddling with task's priorities
>> seems flawed to me.
> 
> Wasn't it the larger timeslices with lower nice values in stock and Con's
> patches that made X with nice -10 a bad idea?

Debian renices X by default to -10 ... I fixed all my desktop interactivity
problems around 2.5.63 timeframe by just turning that off. That was way 
before Con's patches.

There may be some more details around this, and I'd love to hear them,
but I fundmantally believe that explitit fiddling with particular
processes because we believe they're somehow magic is wrong (and so
does Linus, from previous discussions).

M.

