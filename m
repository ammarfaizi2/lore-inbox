Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbVKJNRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbVKJNRR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 08:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbVKJNRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 08:17:16 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:39564 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1750849AbVKJNRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 08:17:14 -0500
Date: Thu, 10 Nov 2005 15:16:30 +0200
From: Gleb Natapov <gleb@minantech.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Hugh Dickins <hugh@veritas.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
Message-ID: <20051110131630.GO8942@minantech.com>
References: <20051110124949.GM8942@minantech.com> <20051110131630.GF16589@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051110131630.GF16589@mellanox.co.il>
X-OriginalArrivalTime: 10 Nov 2005 13:17:12.0501 (UTC) FILETIME=[0FD2AE50:01C5E5F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 03:16:30PM +0200, Michael S. Tsirkin wrote:
> Quoting Gleb Natapov <gleb@minantech.com>:
> > Subject: Re: Nick's core remove PageReserved broke vmware...
> > 
> > On Thu, Nov 10, 2005 at 02:48:53PM +0200, Michael S. Tsirkin wrote:
> > > > Also perhapse we should skip VM_SHARED VMAs?
> > > 
> > > Why?
> > > 
> > They will work correctly across fork(). 
> 
> So why would I call madvise on such a VMA?
> 
Because libraries such as MPI can't figure out if memory is shared or not.
And madvise is just advise, so if kernel knows better it may ignore that
advise.

--
			Gleb.
