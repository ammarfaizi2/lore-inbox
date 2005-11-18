Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030450AbVKRIPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030450AbVKRIPQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 03:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbVKRIPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 03:15:16 -0500
Received: from gold.veritas.com ([143.127.12.110]:13992 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964883AbVKRIPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 03:15:14 -0500
Date: Fri, 18 Nov 2005 08:13:54 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "David S. Miller" <davem@davemloft.net>
cc: nickpiggin@yahoo.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] unpaged: COW on VM_UNPAGED
In-Reply-To: <20051118.000802.81426185.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0511180813110.5788@goblin.wat.veritas.com>
References: <437D6AD0.5080909@yahoo.com.au> <20051117.224516.118147408.davem@davemloft.net>
 <Pine.LNX.4.61.0511180730530.5435@goblin.wat.veritas.com>
 <20051118.000802.81426185.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 18 Nov 2005 08:15:14.0349 (UTC) FILETIME=[33DE15D0:01C5EC18]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2005, David S. Miller wrote:
> From: Hugh Dickins <hugh@veritas.com>
> Date: Fri, 18 Nov 2005 08:02:02 +0000 (GMT)
> 
> > That code is necessary to reproduce the existing behaviour, which has
> > always done COW on PageReserved mappings without complaint - if the
> > vm_page_prot didn't already let you slip through without a WP fault.
> 
> And there is evidence today that this is really needed, at least
> by vbetool.
> 
> Ok, we need COW on VM_UNPAGED. :)

Are you so sure of that, that we should even skip adding a warning?

Hugh
