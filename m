Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136088AbRAGQ5f>; Sun, 7 Jan 2001 11:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136033AbRAGQ5Z>; Sun, 7 Jan 2001 11:57:25 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:37796 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S136108AbRAGQ5H>;
	Sun, 7 Jan 2001 11:57:07 -0500
Date: Sun, 7 Jan 2001 11:56:26 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Chris Wedgwood <cw@f00f.org>
cc: Ben Greear <greearb@candelatech.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
 policy!)
In-Reply-To: <20010107162905.B1804@metastasis.f00f.org>
Message-ID: <Pine.GSO.4.30.0101071144530.18916-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Jan 2001, Chris Wedgwood wrote:

> That said, if this was done -- how would things like routing daemons
> and bind cope?

I dont know of any routing daemons that are taking advantage of the
alias interfaces today. This being said, i think that the fact that a
lot of protocols that need IP-ization are coming up eg VLANs; you should
see a good use for this. Out of curiosity for the VLAN people, how do you
work with something like Zebra?
One could have the route daemon take charge of management of these
devices, a master device like "eth0" and a attached device like "vlan0".
They both share the same ifindex but different have labels.
Basically, i dont think there would be a problem.

cheers,
jamal



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
