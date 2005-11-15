Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbVKOJ0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbVKOJ0r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 04:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbVKOJ0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 04:26:47 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:39280 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1751399AbVKOJ0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 04:26:47 -0500
Date: Tue, 15 Nov 2005 11:26:02 +0200
From: Gleb Natapov <gleb@minantech.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Hugh Dickins <hugh@veritas.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
Message-ID: <20051115092602.GI5492@minantech.com>
References: <20051114150022.GG5492@minantech.com> <20051114202349.GA3603@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114202349.GA3603@mellanox.co.il>
X-OriginalArrivalTime: 15 Nov 2005 09:26:45.0800 (UTC) FILETIME=[B2884A80:01C5E9C6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 10:23:49PM +0200, Michael S. Tsirkin wrote:
> Right. How's this?
> 
Looks good to me now.

> +#define VM_DONTFORK	0x02000000      /* App wants to set VM_DONTCOPY */
Minor nitpicking. I think comment should be changed. Something like:
/* App don't want its child inherit this VMA */ since we don't really
set VM_DONTCOPY.

--
			Gleb.
