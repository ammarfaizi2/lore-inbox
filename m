Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264399AbTFEEKV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 00:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264447AbTFEEKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 00:10:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21509 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264399AbTFEEKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 00:10:20 -0400
Date: Wed, 4 Jun 2003 21:23:16 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Albert Cahalan <albert@users.sourceforge.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>, <davem@redhat.com>,
       <bcollins@debian.org>, <wli@holomorphy.com>, <tom_gall@vnet.ibm.com>,
       <anton@samba.org>
Subject: Re: /proc/bus/pci
In-Reply-To: <1054783303.22104.5569.camel@cube>
Message-ID: <Pine.LNX.4.44.0306042117440.2761-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Jun 2003, Albert Cahalan wrote:
>
> I notice that /proc/bus/pci doesn't offer a sane
> interface for multiple PCI domains and choice of BAR.
> What do people think of this?
> 
> bus/pci/00/00.0 -> ../hose0/bus0/dev0/fn0/config-space

Why do we have that stupid "hose" name? Only because of strange alpha 
naming, or did somebody else also use that incredibly silly name?

Please talk about "domains", at least it makes some sense as a name.

I'm also hoping that /proc/bus will eventually go away, so I don't see a 
major problem with not understanding multiple domains at that level.

On a /sys/bus/xxx level we actually should already be able to handle 
multiple domains, but the naming is broken. However, in /sys we should be 
able to nicely handling non-zero domains by just extending the name space 
a bit.

		Linus

