Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVBHXx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVBHXx7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 18:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVBHXx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 18:53:59 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:10245 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S261699AbVBHXx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 18:53:57 -0500
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
	crypto_tfm
From: Fruhwirth Clemens <clemens@endorphin.org>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       michal@logix.cz, "David S. Miller" <davem@davemloft.net>,
       "Adam J. Richter" <adam@yggdrasil.com>
In-Reply-To: <Xine.LNX.4.44.0502081821180.1670-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0502081821180.1670-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 09 Feb 2005 00:53:56 +0100
Message-Id: <1107906836.15942.131.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-08 at 18:30 -0500, James Morris wrote:
> On Tue, 8 Feb 2005, Fruhwirth Clemens wrote:
> 
> > I shot out the last patch too quickly. Having reviewed the mapping one
> > more time I noticed, that there as the possibility of "off-by-one"
> > unmapping, and instead of doing doubtful guesses, if that's the case, I
> > added a base pointer to scatter_walk, which is the pointer returned by
> > kmap. Exactly this pointer will be unmapped again, so the vaddr
> > comparison in crypto_kunmap doesn't have to do any masking.
> 
> You can't call kmap() in softirq context (why was it even trying?):

Why not? What's the alternative, then?

-- 
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org
