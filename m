Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBIKes>; Fri, 9 Feb 2001 05:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129030AbRBIKei>; Fri, 9 Feb 2001 05:34:38 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:5901 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S129027AbRBIKeW>; Fri, 9 Feb 2001 05:34:22 -0500
Date: Fri, 9 Feb 2001 10:34:18 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: ARP out the wrong interface
In-Reply-To: <Pine.LNX.4.33.0102082058060.21439-100000@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.10.10102091030390.17807-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, dean gaudet wrote:

> responses come back from both eth0 and eth1, listing each of their
> respective MAC addresses...  it's essentially a race condition at this
> point as to whether i'll get the right MAC address.  ("right" means
> the MAC for server:eth1).

2.2.18 and 2.4 apparently have a patch called "arpfilter"
integrated which should allow you to:

# sysctl -w net.ipv4.conf.all.arpfilter=1

to get much stricter behaviour regarding ARP replies.

Matthew.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
