Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262387AbSLMLyY>; Fri, 13 Dec 2002 06:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262442AbSLMLyO>; Fri, 13 Dec 2002 06:54:14 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:51157 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S262387AbSLMLyK>; Fri, 13 Dec 2002 06:54:10 -0500
Date: Sat, 14 Dec 2002 00:48:54 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>,
       "David S. Miller" <davem@redhat.com>
cc: dlstevens@us.ibm.com, matti.aarnio@zmailer.org, niv@us.ibm.com,
       alan@lxorguk.ukuu.org.uk, stefano.andreani.ap@h3g.it,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: R: Kernel bug handling TCP_RTO_MAX?
Message-ID: <19000000.1039780134@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0212131233220.11129-100000@kenzo.iwr.uni-heidelberg.de>
References: <Pine.LNX.4.44.0212131233220.11129-100000@kenzo.iwr.uni-heidelbe
 rg.de>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're going to make lots of IETFer's really annoyed by suggesting that :-)

Honestly, there are lots of other ways to solve this, and it would be nice 
if the IETF's recent additions got implemented; there are many relevant 
things going on there.  Those interested should just talk to the draft 
authors about implementing things.  It's an open organisation just like 
linux-kernel after all, just a bit more formal.

In a closed network, why not have SOCK_STREAM map to something faster than 
TCP anyway?  That is, if I connect(address matching localnet), SOCK_STREAM 
maps to (eg) SCTP.  That would be a far more dramatic performance hack!

Andrew

--On Friday, December 13, 2002 12:46:15 +0100 Bogdan Costescu 
<bogdan.costescu@iwr.uni-heidelberg.de> wrote:

> On Thu, 12 Dec 2002, David S. Miller wrote:
>
>> This is well understood, the problem is that BSD's coarse timers are
>> going to cause all sorts of problems when a Linux stack with a reduced
>> MIN RTO talks to it.
>
> Sorry to jump into the discussion without a good understanding of inner
> workings of TCP, I just want to share my view as a possible user of this:
> one of the messages at the beginning of the thread said that this would
> be  useful on a closed network and I think that this point was overlooked.
>
> Think of a closed network with only Linux machines on it (world
> domination, right :-))  like a Beowulf cluster, web frontends talking to
> NFS fileservers, web frontends talking to database backends, etc. Again
> as  proposed earlier, border hosts (those connected to both the closed
> network and outside one) could change their communication parameters
> based  on device or route and this would become an internal affair that
> would not  affect communication with other stacks.
>
> I don't want to suggest to make this the default behaviour; rather, have
> it a parameter that can be changed by the sysadmin and have the current
> value as default.
>
> --
> Bogdan Costescu
>
> IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
> Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
> Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
> E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


