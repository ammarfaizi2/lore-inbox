Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129641AbRAXOdi>; Wed, 24 Jan 2001 09:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129939AbRAXOdT>; Wed, 24 Jan 2001 09:33:19 -0500
Received: from dsl.75.131.networkiowa.com ([209.234.75.131]:17418 "EHLO
	www.sjdjweis.com") by vger.kernel.org with ESMTP id <S129641AbRAXOdJ>;
	Wed, 24 Jan 2001 09:33:09 -0500
Date: Wed, 24 Jan 2001 13:14:37 -0600 (CST)
From: David Weis <djweis@sjdjweis.com>
To: Ben Greear <greearb@candelatech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: changing mac address of eth alias
In-Reply-To: <3A6E4040.86D750D7@candelatech.com>
Message-ID: <Pine.LNX.4.21.0101241309410.25159-100000@www.sjdjweis.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 23 Jan 2001, Ben Greear wrote:
> David Weis wrote:
> > what would be required to make the mac address of aliases changable,
> > specifically for something like vrrp that shares a mac address among
> > machines.
> 
> Not sure you can do that, but you could use an 802.1Q vlan patch
> and set up two different VLANs.  You can now change the MAC
> address on a VLAN with my patch: http://scry.wanfear.com/~greear/vlan.html

I'm looking at your code, in the function
vlan_dev_set_multicast_list() for the 2.4 tree, you enable promiscuity and
reception of all multicast packets. Is this necessary for all cards? 

This looks pretty close to what I was looking for, thanks for the
pointer. Do the multicast functions have enough usefulness for things
other than VLAN to be split out separately?

dave

-- 
Dave Weis             "I believe there are more instances of the abridgement
djweis@sjdjweis.com   of the freedom of the people by gradual and silent
                      encroachments of those in power than by violent 
                      and sudden usurpations."- James Madison

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
