Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268896AbUIHG5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268896AbUIHG5w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 02:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268899AbUIHG5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 02:57:51 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:42645 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S268896AbUIHG44
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 02:56:56 -0400
From: Duncan Sands <baldrick@free.fr>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] netpoll endian fixes
Date: Wed, 8 Sep 2004 08:56:55 +0200
User-Agent: KMail/1.6.2
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <200409080124.43530.baldrick@free.fr> <20040907232927.GB31237@waste.org>
In-Reply-To: <20040907232927.GB31237@waste.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409080856.56568.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 September 2004 01:29, Matt Mackall wrote:
> On Wed, Sep 08, 2004 at 01:24:43AM +0200, Duncan Sands wrote:
> > The big-endians took their revenge in netpoll.c: on i386,
> > the ip header length / version nibbles need to be the other
> > way round; and the htonl leaves only zeros in tot_len...
> 
> I'm completely baffled as to how length / version nibbles could be
> swapped. Endianness here should be a matter of _bytes_.

I also don't understand it.  The definition of struct iphdr contains:

#if defined(__LITTLE_ENDIAN_BITFIELD)
        __u8    ihl:4,
                version:4;
#elif defined (__BIG_ENDIAN_BITFIELD)
        __u8    version:4,
                ihl:4;

What does it mean?

All the best,

Duncan.
