Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131063AbRAGSww>; Sun, 7 Jan 2001 13:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131124AbRAGSwm>; Sun, 7 Jan 2001 13:52:42 -0500
Received: from gleb.nbase.co.il ([194.90.136.56]:35084 "EHLO gleb.nbase.co.il")
	by vger.kernel.org with ESMTP id <S129994AbRAGSwb>;
	Sun, 7 Jan 2001 13:52:31 -0500
From: Gleb Natapov <gleb@nbase.co.il>
Date: Sun, 7 Jan 2001 20:51:13 +0200
To: jamal <hadi@cyberus.ca>
Cc: Ben Greear <greearb@candelatech.com>, Chris Wedgwood <cw@f00f.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: routable interfaces  WAS( Re: [PATCH] hashed device lookup (DoesNOT  meet Linus' sumission policy!)
Message-ID: <20010107205113.H28257@nbase.co.il>
In-Reply-To: <3A58C1C9.1E4B6265@candelatech.com> <Pine.GSO.4.30.0101071321330.18916-100000@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.30.0101071321330.18916-100000@shell.cyberus.ca>; from hadi@cyberus.ca on Sun, Jan 07, 2001 at 01:29:51PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 01:29:51PM -0500, jamal wrote:
> 
> 
> On Sun, 7 Jan 2001, Ben Greear wrote:
> 
> > > My thought was to have the vlan be attached on the interface ifa list and
> > > just give it a different label since it is a "virtual interface" on top
> > > of the "physical interface". Now that you mention the SNMP requirement,
> > > maybe an idea of major:minor ifindex makes sense. Say make the ifindex
> > > a u32 with major 16 bit and minor 16 bit. This way we can have upto 2^16
> > > physical interfaces and upto 2^16 virtual interfaces on the physical
> > > interface. The search will be broken into two 16 bits.
> >
> > What problem does this fix?
> >
> > If you are mucking with the ifindex, you may be affecting many places
> > in the rest of the kernel, as well as user-space programs which use
> > ifindex to bind to raw devices.
> >
> 
> I am talking about 2.5 possibilities now that 2.4 is out. I think
> "parasitic/virtual" interfaces is not a issue specific to VLANs.
> VLANs happen to use devices today to solve the problem.
> As pointed by that example no routing daemons are doing aliased
> interfaces (which are also virtual interfaces).
> We need some more general solution.
>

And what about bonding device? What major number should they use? 

Ifindexes not reusable so in your scheme we should have separate minor 
counter for each major interface, what for?

--
			Gleb.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
