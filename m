Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261700AbSI0OOZ>; Fri, 27 Sep 2002 10:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261701AbSI0OOZ>; Fri, 27 Sep 2002 10:14:25 -0400
Received: from mail.cyberus.ca ([216.191.240.111]:40446 "EHLO cyberus.ca")
	by vger.kernel.org with ESMTP id <S261700AbSI0OOY>;
	Fri, 27 Sep 2002 10:14:24 -0400
Date: Fri, 27 Sep 2002 10:12:26 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: "David S. Miller" <davem@redhat.com>
cc: <jmorris@intercode.com.au>, <rusty@rustcorp.com.au>, <nf@hipac.org>,
       <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification for
 Netfilter
In-Reply-To: <20020926.135259.62665945.davem@redhat.com>
Message-ID: <Pine.GSO.4.30.0209270958210.4401-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dave,

now that i followed the thread on lk (slrn is great; thanks Jason);
I am actually interested to find out how you are going to pull what
you propose ;-> There are not that many things that will work well
with a dst-cache like idea. I actually considered the stacking idea
when i first was trying to prototype code that i posted. It is much harder
to make use of in practise. At least this is my experience.
If you look at the scheme i posted, youll see that the policy
could be to direct the packets to a IPV4-forwarding block or
totaly bypass it etc (i just didnt wanna jump into that step yet sicne it
is quiet involved architecturaly)
In any case we need to encourage people like the hipac authors to be
putting out things (i only wish theyd incorporate it into the tc
framework!); whatever changes made should consider that there is
more than one way to do things and people will always come with better
ways to do certain portions of the packet path.

cheers,
jamal

On Thu, 26 Sep 2002, David S. Miller wrote:

>    From: James Morris <jmorris@intercode.com.au>
>    Date: Fri, 27 Sep 2002 01:27:41 +1000 (EST)
>
>    So, this could be used for generic network layer encapsulation, and be
>    used for GRE tunnels, SIT etc. without the kinds of kludges currently in
>    use?  Sounds nice.
>
> Such IPIP tunnels have very real problems though, since only 64-bits
> of packet quoting are required in ICMP errors, it is often impossible
> to deal with PMTU requests properly, see "#ifndef
> I_WISH_WORLD_WERE_PERFECT" in net/ipv4/ip_gre.c
>
>
>

