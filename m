Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129310AbRB0AVo>; Mon, 26 Feb 2001 19:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129311AbRB0AVf>; Mon, 26 Feb 2001 19:21:35 -0500
Received: from peace.netnation.com ([204.174.223.2]:12817 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S129310AbRB0AVU>; Mon, 26 Feb 2001 19:21:20 -0500
Date: Mon, 26 Feb 2001 16:21:07 -0800
From: Simon Kirby <sim@netnation.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Jordan Mendelson <jordy@napster.com>, ookhoi@dds.nl,
        Vibol Hou <vibol@khmer.cc>,
        Linux-Kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: Re: 2.4 tcp very slow under certain circumstances (Re: netdev issues (3c905B))
Message-ID: <20010226162107.A31575@netnation.com>
In-Reply-To: <HDEBKHLDKIDOBMHPKDDKMEGDEFAA.vibol@khmer.cc> <20010221104723.C1714@humilis> <14995.40701.818777.181432@pizda.ninka.net> <3A9453F4.993A9A74@napster.com> <14996.21701.542448.49413@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <14996.21701.542448.49413@pizda.ninka.net>; from davem@redhat.com on Wed, Feb 21, 2001 at 03:52:37PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2001 at 03:52:37PM -0800, David S. Miller wrote:

> There is no reason my patch should have this effect.
> 
> All of this is what appears to be a bug in Windows TCP header
> compression, if the ID field of the IPv4 header does not change then
> it drops every other packet.
> 
> The change I posted as-is, is unacceptable because it adds unnecessary
> cost to a fast path.  The final change I actually use will likely
> involve using the TCP sequence numbers to calculate an "always
> changing" ID number in the IPv4 headers to placate these broken
> windows machines.

Has such a patch gone in to the kernel yet?

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
