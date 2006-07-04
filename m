Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWGDMwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWGDMwP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 08:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWGDMwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 08:52:14 -0400
Received: from mxl145v64.mxlogic.net ([208.65.145.64]:39636 "EHLO
	p02c11o141.mxlogic.net") by vger.kernel.org with ESMTP
	id S1750822AbWGDMwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 08:52:14 -0400
Date: Tue, 4 Jul 2006 15:52:22 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Ingo Molnar <mingo@elte.hu>
Cc: Zach Brown <zach.brown@oracle.com>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH] mthca: initialize send and receive queue locks separately
Message-ID: <20060704125222.GZ21049@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060704115656.GA1539@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060704115656.GA1539@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 04 Jul 2006 12:57:05.0421 (UTC) FILETIME=[59D5E3D0:01C69F69]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [63.251.237.3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Ingo Molnar <mingo@elte.hu>:
> Subject: Re: [PATCH] mthca: initialize send and receive queue locks separately
> 
> 
> * Michael S. Tsirkin <mst@mellanox.co.il> wrote:
> 
> > > Has no effect on non-lockdep kernels.
> > 
> > Hmm ... adding parameters to function still has text cost, I think. No?
> 
> it shouldnt - it's a static function and the parameter is unused _and_ 
> is of a type that is zero-size [on non-lockdep kernels] - gcc ought to 
> be able to optimize it out.

Ingo, you are right, and I just checked this with several gcc versions.
More power to you :)

-- 
MST
