Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265568AbSLMWuc>; Fri, 13 Dec 2002 17:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbSLMWuc>; Fri, 13 Dec 2002 17:50:32 -0500
Received: from mail.zmailer.org ([62.240.94.4]:62422 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S265523AbSLMWua>;
	Fri, 13 Dec 2002 17:50:30 -0500
Date: Sat, 14 Dec 2002 00:58:19 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Nivedita Singhvi <niv@us.ibm.com>
Cc: Andrew McGregor <andrew@indranet.co.nz>,
       Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>,
       "David S. Miller" <davem@redhat.com>, dlstevens@us.ibm.com,
       matti.aarnio@zmailer.org, alan@lxorguk.ukuu.org.uk,
       stefano.andreani.ap@h3g.it, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: R: Kernel bug handling TCP_RTO_MAX?
Message-ID: <20021213225819.GO32122@mea-ext.zmailer.org>
References: <Pine.LNX.4.44.0212131233220.11129-100000@kenzo.iwr.uni-heidelberg.de> <19000000.1039780134@localhost.localdomain> <3DFA21C5.867C6320@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DFA21C5.867C6320@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2002 at 10:07:01AM -0800, Nivedita Singhvi wrote:
> Andrew McGregor wrote:
> > In a closed network, why not have SOCK_STREAM map to something faster than
> > TCP anyway?  That is, if I connect(address matching localnet), SOCK_STREAM
> > maps to (eg) SCTP.  That would be a far more dramatic performance hack!
> > 
> > Andrew
> 
> Not that simple. SCTP (if that is what Matti was referring to) is 
> a SOCK_STREAM socket, with a protocol of IPPROTO_SCTP. I'm just
> getting done implementing a testsuite against the SCTP API.

  Most likely that is what I did mean.
Things in IETF do on occasion change names, or I don't always
remember all characters in (E)TLA-acronyms I use rarely...

...
> But dont expect SCTP to be the surreptitious underlying layer
> carrying TCP traffic, if thats an expectation that anyone has :)

At least I didn't expect that, don't know of others.

It all depends on application coders, if users will be able
to use arbitrary network protocols -- say any SOCK_STREAM
protocol supported now, and in future by system kernel.
Ever heard of "TLI" ?

> Solving this problem without application involvement is a 
> more limited scenario..

Yes, but sufficiently important to occasionally.

Doing things like this mapping might make limited sense
via routing table lookups.

> thanks,
> Nivedita

/Matti Aarnio
