Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbWA0KLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWA0KLR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 05:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWA0KLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 05:11:17 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:49583 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932461AbWA0KLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 05:11:16 -0500
Date: Fri, 27 Jan 2006 02:10:50 -0800
From: Paul Jackson <pj@sgi.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: colpatch@us.ibm.com, bcrl@kvack.org, clameter@engr.sgi.com,
       linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
Subject: Re: [patch 0/9] Critical Mempools
Message-Id: <20060127021050.f50d358d.pj@sgi.com>
In-Reply-To: <84144f020601262335g49c21b62qaa729732e9275c0@mail.gmail.com>
References: <1138217992.2092.0.camel@localhost.localdomain>
	<Pine.LNX.4.62.0601260954540.15128@schroedinger.engr.sgi.com>
	<43D954D8.2050305@us.ibm.com>
	<Pine.LNX.4.62.0601261516160.18716@schroedinger.engr.sgi.com>
	<43D95BFE.4010705@us.ibm.com>
	<20060127000304.GG10409@kvack.org>
	<43D968E4.5020300@us.ibm.com>
	<84144f020601262335g49c21b62qaa729732e9275c0@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka wrote:
> As as side note, we already have __GFP_NOFAIL. How is it different
> from GFP_CRITICAL and why aren't we improving that?

Don't these two flags invoke two different mechanisms.
  __GFP_NOFAIL can sleep for HZ/50 then retry, rather than return failure.
  __GFP_CRITICAL can steal from the emergency pool rather than fail.

I would favor renaming at least the __GFP_CRITICAL to something
like __GFP_EMERGPOOL, to highlight the relevant distinction.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
