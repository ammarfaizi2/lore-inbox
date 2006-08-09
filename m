Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030550AbWHIGaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030550AbWHIGaM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 02:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030547AbWHIGaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 02:30:12 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:50594 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030546AbWHIGaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 02:30:09 -0400
Message-ID: <44D980EB.5010608@garzik.org>
Date: Wed, 09 Aug 2006 02:30:03 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: phillips@google.com, a.p.zijlstra@chello.nl, netdev@vger.kernel.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 8/9] 3c59x driver conversion
References: <20060808193447.1396.59301.sendpatchset@lappy>	<44D9191E.7080203@garzik.org>	<44D977D8.5070306@google.com> <20060808.225537.112622421.davem@davemloft.net>
In-Reply-To: <20060808.225537.112622421.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> From: Daniel Phillips <phillips@google.com>
> Date: Tue, 08 Aug 2006 22:51:20 -0700
> 
>> Elaborate please.  Do you think that all drivers should be updated to
>> fix the broken blockdev semantics, making NETIF_F_MEMALLOC redundant?
>> If so, I trust you will help audit for it?
> 
> I think he's saying that he doesn't think your code is yet a
> reasonable way to solve the problem, and therefore doesn't belong
> upstream.

Pretty much.  It is completely non-sensical to add NETIF_F_MEMALLOC, 
when it should be blindingly obvious that every net driver will be 
allocating memory, and every net driver could potentially be used with 
NBD and similar situations.

	Jeff


