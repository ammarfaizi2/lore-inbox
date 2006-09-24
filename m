Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWIXH0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWIXH0N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 03:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752183AbWIXH0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 03:26:13 -0400
Received: from cantor2.suse.de ([195.135.220.15]:10893 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751118AbWIXH0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 03:26:12 -0400
From: Andi Kleen <ak@suse.de>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: More thoughts on getting rid of ZONE_DMA
Date: Sun, 24 Sep 2006 09:26:40 +0200
User-Agent: KMail/1.9.1
Cc: Christoph Lameter <clameter@sgi.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       akpm@google.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       James Bottomley <James.Bottomley@steeleye.com>, linux-mm@kvack.org
References: <Pine.LNX.4.64.0609212052280.4736@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0609231907360.16435@schroedinger.engr.sgi.com> <4515EF28.9000805@mbligh.org>
In-Reply-To: <4515EF28.9000805@mbligh.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609240926.41208.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If it's the 16MB DMA window for ia32 we're talking about, wouldn't
> it be easier just to remove it from the fallback lists? (assuming
> you have at least 128MB of memory or something, blah, blah). Saves
> doing migration later.

That is essentially already the case because the mm has special
heuristics to preserve lower zones. Usually those tend to keep the
16MB mostly free unless you really use GFP_DMA.

-Andi

