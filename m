Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262676AbVCWAxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbVCWAxn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 19:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbVCWAxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 19:53:42 -0500
Received: from ozlabs.org ([203.10.76.45]:10384 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262675AbVCWAx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 19:53:28 -0500
Date: Wed, 23 Mar 2005 11:53:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel McNeil <daniel@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       "linuxppc64-dev@ozlabs.org" <linuxppc64-dev@ozlabs.org>,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
Subject: Re: [PATCH 2.6.11] AIO panic on PPC64 caused by is_hugepage_only_range()
Message-ID: <20050323005305.GB29765@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Daniel McNeil <daniel@osdl.org>, Andrew Morton <akpm@osdl.org>,
	"linuxppc64-dev@ozlabs.org" <linuxppc64-dev@ozlabs.org>,
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-aio@kvack.org" <linux-aio@kvack.org>
References: <1111108348.31932.43.camel@ibm-c.pdx.osdl.net> <20050321184113.0f5e2f6b.akpm@osdl.org> <1111519474.15956.40.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111519474.15956.40.camel@ibm-c.pdx.osdl.net>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 11:24:34AM -0800, Daniel McNeil wrote:
> On Mon, 2005-03-21 at 18:41, Andrew Morton wrote:
> > Did we fix this yet?
> > 
> 
> Here's a patch against 2.6.11 that fixes the problem.
> It changes is_hugepage_only_range() to take mm as an argument
> and then changes the places that call it to pass 'mm'.
> It includes a change for ia64 which has not been compiled.
> It applies against the latest bk with some offset.
> 
> Signed-off-by: Daniel McNeil <daniel@osdl.org>

Looks good to me.

Acked-by: David Gibson <dwg@au1.ibm.com>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
