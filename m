Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbTKGW20 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbTKGW1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:27:48 -0500
Received: from zok.sgi.com ([204.94.215.101]:46778 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S264165AbTKGWB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 17:01:58 -0500
Date: Fri, 7 Nov 2003 14:01:50 -0800
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use NODES_SHIFT to calculate ZONE_SHIFT
Message-ID: <20031107220150.GA1799@sgi.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20031105211608.GA23560@sgi.com> <20031107135806.3c929688.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031107135806.3c929688.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 07, 2003 at 01:58:06PM -0800, Andrew Morton wrote:
> jbarnes@sgi.com (Jesse Barnes) wrote:
> >
> > Now that we have a proper NODES_SHIFT value, we need to use it to define
> > ZONE_SHIFT otherwise we'll spill over 8 bits if we have more than 85
> > nodes.  How does this look?  The '+2' should really be
> > log2(MAX_NR_NODES), but I think this is an improvement over what was
> > there.
> 
> You mean log2(MAX_NR_ZONES).

Yep, sorry.

> How about we do it this way, so at least the duplicated information is on
> adjacent lines, and they are unlikely to get out of sync?

Yeah, this looks great.

Thanks,
Jesse
