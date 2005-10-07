Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030471AbVJGS2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030471AbVJGS2x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 14:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030527AbVJGS2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 14:28:52 -0400
Received: from twin.jikos.cz ([213.151.79.26]:35262 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1030471AbVJGS2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 14:28:52 -0400
Date: Fri, 7 Oct 2005 20:28:17 +0200
From: Rudo Thomas <rudo@matfyz.cz>
To: Gustavo Barbieri <barbieri@gmail.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, ck@vds.kolivas.org,
       linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] vm - swap_prefetch-15
Message-ID: <20051007182817.GA8145@jikos.cz>
Mail-Followup-To: Gustavo Barbieri <barbieri@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>, ck@vds.kolivas.org,
	linux-kernel@vger.kernel.org
References: <200510070001.01418.kernel@kolivas.org> <84144f020510070303u13872f33hb4a40451acea4d5a@mail.gmail.com> <200510072054.11145.kernel@kolivas.org> <84144f020510070431n3b18250eo9d4777844a448b8a@mail.gmail.com> <9ef20ef30510070744l7ff1f1bbweb4da1ceb513f246@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ef20ef30510070744l7ff1f1bbweb4da1ceb513f246@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Or make it a "const static" variable, so compiler will check types and
> everything, but the symbol will not be present in the binary, causing
> no overhead. So it could be:
> 
> const unsigned PREFETCH_PAGES = (SWAP_CLUSTER_MAX * swap_prefetch * \
>         (1 + 9 * laptop_mode));

This won't work, AFAICT. swap_prefetch and laptop_mode are variables,
but with the code above, they would be evaluated only once. And maybe
the compiler will reject that code immediately...

Rudo.
