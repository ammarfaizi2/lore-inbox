Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVADNPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVADNPT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 08:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVADNPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 08:15:18 -0500
Received: from holomorphy.com ([207.189.100.168]:31878 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261625AbVADNOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 08:14:33 -0500
Date: Tue, 4 Jan 2005 05:11:10 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Felipe Alfaro Solana <lkml@mac.com>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, Rik van Riel <riel@redhat.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@debian.org>
Subject: Re: starting with 2.7
Message-ID: <20050104131110.GE2708@holomorphy.com>
References: <6D2C0E07-5DAE-11D9-9FD3-000D9352858E@mac.com> <200501032059.j03KxOEB004666@laptop11.inf.utfsm.cl> <20050104054458.GB7048@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104054458.GB7048@alpha.home.local>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 05:59:24PM -0300, Horst von Brand wrote:
>> Open up the code. Most of the changes will then be done as a matter of
>> course by others.

On Tue, Jan 04, 2005 at 06:44:58AM +0100, Willy Tarreau wrote:
> it will not solve the problem : if a driver or any glue logic breaks, it's
> because interface has changed again. When you will have 3000 open drivers,
> you'll have to find people to make the changes every week. The solution in
> the first place is to respect some code stability and not to break thinks
> every week.

Tihs is not entirely true. I'd like to point to remap_pfn_range() as a
smoothly-executed API change. All in-tree drivers were swept. Out-of-
tree open-source drivers got by with nothing more than warnings. Even
binary-only drivers had no trouble with mere recompiles of glue layers.

Many other API changes are also executed with similar smoothness.


-- wli
