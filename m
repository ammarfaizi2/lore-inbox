Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131778AbRAGRj3>; Sun, 7 Jan 2001 12:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136127AbRAGRjT>; Sun, 7 Jan 2001 12:39:19 -0500
Received: from gleb.nbase.co.il ([194.90.136.56]:266 "EHLO gleb.nbase.co.il")
	by vger.kernel.org with ESMTP id <S131778AbRAGRjK>;
	Sun, 7 Jan 2001 12:39:10 -0500
From: Gleb Natapov <gleb@nbase.co.il>
Date: Sun, 7 Jan 2001 19:37:57 +0200
To: jamal <hadi@cyberus.ca>
Cc: Chris Wedgwood <cw@f00f.org>, Ben Greear <greearb@candelatech.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission policy!)
Message-ID: <20010107193757.F28257@nbase.co.il>
In-Reply-To: <20010107162905.B1804@metastasis.f00f.org> <Pine.GSO.4.30.0101071144530.18916-100000@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.30.0101071144530.18916-100000@shell.cyberus.ca>; from hadi@cyberus.ca on Sun, Jan 07, 2001 at 11:56:26AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 11:56:26AM -0500, jamal wrote:
> 
> 
> On Sun, 7 Jan 2001, Chris Wedgwood wrote:
> 
> > That said, if this was done -- how would things like routing daemons
> > and bind cope?
> 
> I dont know of any routing daemons that are taking advantage of the
> alias interfaces today. This being said, i think that the fact that a
> lot of protocols that need IP-ization are coming up eg VLANs; you should
> see a good use for this. Out of curiosity for the VLAN people, how do you
> work with something like Zebra?

Without any problems. Zebra sees different VLAN interfaces as different networks
and happily route between them.

> One could have the route daemon take charge of management of these
> devices, a master device like "eth0" and a attached device like "vlan0".
> They both share the same ifindex but different have labels.
> Basically, i dont think there would be a problem.
>

Theoretically it seems to be possible but it's much harder to do in Zebra than 
in kernel. And "eth0" shouldn't share ifindex with "vlan0" I don't think SNMP
will be happy about that.

--
			Gleb.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
