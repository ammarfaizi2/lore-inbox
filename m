Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030420AbWGZGmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030420AbWGZGmo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 02:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030422AbWGZGmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 02:42:44 -0400
Received: from mxl145v69.mxlogic.net ([208.65.145.69]:17857 "EHLO
	p02c11o146.mxlogic.net") by vger.kernel.org with ESMTP
	id S1030420AbWGZGmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 02:42:43 -0400
Date: Wed, 26 Jul 2006 09:43:49 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Zach Brown <zach.brown@oracle.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH] lockdep: don't pull in includes when lockdep disabled
Message-ID: <20060726064349.GA8874@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <1153895599.2896.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153895599.2896.4.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 26 Jul 2006 06:48:11.0859 (UTC) FILETIME=[764ADA30:01C6B07F]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Arjan van de Ven <arjan@infradead.org>:
> Subject: Re: [PATCH] lockdep: don't pull in includes when lockdep disabled
> 
> On Wed, 2006-07-26 at 09:26 +0300, Michael S. Tsirkin wrote:
> > Ingo, does the following look good to you?
> > 
> > Do not pull in various includes through lockdep.h if lockdep is disabled.
> 
> Hi,
> 
> can you tell us what this fixes? Eg is there a specific problem?

Er ... it's a cosmetic change - there's no serious problem, it is just that even
if I disable lockdep, linux/lockdep.h will pull in several headers even
though they are not needed -> more useless work for compiler to do.

> I mean... we're adding ifdefs

Note this doesn't add ifdefs, just moves them around.

> so there better be a real good reason for
> them.... fixing something real would be such a reason ;-)

Well, I don't expect this specific bit to speed compilation up in any measurable
way, but unnecessary includes do have the tendency to accumulate and lead to
slower builds ...

Is that a reason?

-- 
MST
