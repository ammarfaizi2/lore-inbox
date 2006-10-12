Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWJLSNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWJLSNy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 14:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWJLSNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 14:13:54 -0400
Received: from iriserv.iradimed.com ([69.44.168.233]:30427 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1750984AbWJLSNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 14:13:53 -0400
Message-ID: <452E85ED.1040409@cfl.rr.com>
Date: Thu, 12 Oct 2006 14:14:05 -0400
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Alasdair G Kergon <agk@redhat.com>, Phillip Susi <psusi@cfl.rr.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Heinz Mauelshagen <mauelshagen@redhat.com>
Subject: Re: dm stripe: Fix bounds
References: <20060316151114.GS4724@agk.surrey.redhat.com> <452DBE11.2000005@cfl.rr.com> <20061012135945.GV17654@agk.surrey.redhat.com> <452E5FD0.8060309@cfl.rr.com> <20061012160515.GD17654@agk.surrey.redhat.com>
In-Reply-To: <20061012160515.GD17654@agk.surrey.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Oct 2006 18:14:06.0464 (UTC) FILETIME=[3491B800:01C6EE2A]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14746.003
X-TM-AS-Result: No--10.259100-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So you are saying that dmraid should build 3 tables: 1 for the bulk of 
the array, 1 for only the last stripe, and 1 linear to connect them?

I'm not sure where the ambiguity is.  Obviously all the stripes prior to 
the last should behave normally, the only problem comes from the last 
stripe.  How else could you map the last stripe other than laying down x 
sectors onto y drives as x / y sectors on each drive in sequence?


Alasdair G Kergon wrote:
> But there's ambiguity: should dm truncate just the last stripe(s) or all
> stripes equally, or use some other combination of truncation?  The answer
> depends on the circumstances, and so it is for userspace, which should know
> which of those is required, to resolve the matter by supplying appropriate
> chunk sizes.
> 
> Alasdair

