Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130338AbRAGTUs>; Sun, 7 Jan 2001 14:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131528AbRAGTUi>; Sun, 7 Jan 2001 14:20:38 -0500
Received: from storm.ca ([209.87.239.69]:13243 "EHLO mail.storm.ca")
	by vger.kernel.org with ESMTP id <S130338AbRAGTUY>;
	Sun, 7 Jan 2001 14:20:24 -0500
Message-ID: <3A58C137.63907CDC@storm.ca>
Date: Sun, 07 Jan 2001 14:19:19 -0500
From: Sandy Harris <sandy@storm.ca>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en,fr
MIME-Version: 1.0
To: jamal <hadi@cyberus.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: routable interfaces  WAS( Re: [PATCH] hashed device lookup(DoesNOT  
 meet Linus' sumission policy!)
In-Reply-To: <Pine.GSO.4.30.0101071321330.18916-100000@shell.cyberus.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:

> > What problem does this fix?
> >
> > If you are mucking with the ifindex, you may be affecting many places
> > in the rest of the kernel, as well as user-space programs which use
> > ifindex to bind to raw devices.
>
> I am talking about 2.5 possibilities now that 2.4 is out. I think
> "parasitic/virtual" interfaces is not a issue specific to VLANs.
> VLANs happen to use devices today to solve the problem.
> As pointed by that example no routing daemons are doing aliased
> interfaces (which are also virtual interfaces).
> We need some more general solution.
> 
Something like this also becomes an issue when you want routing
daemons to interact sensibly with IPSEC tunnels. A paper on these
issues is at:

http://www.quintillion.com/fdis/moat/ipsec+routing/

It is not (AFAIK) clear that the FreeS/WAN team will adopt the solutions
suggested there, but it is very clear we need to deal with those issues.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
