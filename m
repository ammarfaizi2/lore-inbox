Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265532AbSLMWde>; Fri, 13 Dec 2002 17:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265523AbSLMWde>; Fri, 13 Dec 2002 17:33:34 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:727 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S265516AbSLMWdc>; Fri, 13 Dec 2002 17:33:32 -0500
Date: Sat, 14 Dec 2002 11:25:28 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Nivedita Singhvi <niv@us.ibm.com>
cc: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>,
       "David S. Miller" <davem@redhat.com>, dlstevens@us.ibm.com,
       matti.aarnio@zmailer.org, alan@lxorguk.ukuu.org.uk,
       stefano.andreani.ap@h3g.it, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: R: Kernel bug handling TCP_RTO_MAX?
Message-ID: <2280000.1039818328@localhost.localdomain>
In-Reply-To: <3DFA21C5.867C6320@us.ibm.com>
References: <Pine.LNX.4.44.0212131233220.11129-100000@kenzo.iwr.uni-heidelbe	
  rg.de> <19000000.1039780134@localhost.localdomain>
 <3DFA21C5.867C6320@us.ibm.com>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Friday, December 13, 2002 10:07:01 -0800 Nivedita Singhvi 
<niv@us.ibm.com> wrote:

> Andrew McGregor wrote:
>
>> In a closed network, why not have SOCK_STREAM map to something faster
>> than TCP anyway?  That is, if I connect(address matching localnet),
>> SOCK_STREAM maps to (eg) SCTP.  That would be a far more dramatic
>> performance hack!
>>
>> Andrew
>
> Not that simple. SCTP (if that is what Matti was referring to) is
> a SOCK_STREAM socket, with a protocol of IPPROTO_SCTP. I'm just
> getting done implementing a testsuite against the SCTP API.
>
> i.e. You have to know you want an SCTP socket at the time you
> open the socket. You certainly have no idea whether youre on
> a closed network or not, for that matter, the app may want to talk
> on multiple interfaces etc. (Most hosts will have one interface
> on a public net)..

Things are never that simple.  But I was basically talking about a local 
policy to change the (semantics of the) API in certain cases.  It's 
probably a bad idea and would cause all kinds of breakage, but it is 
interesting to think about.

>
> Currently, Linux SCTP doesn't yet support TCP style i.e SOCK_STREAM
> sockets, we only do udp-style sockets (SOCK_SEQPACKET).  We will be
> putting in SOCK_STREAM support next, but understand that performance
> is not something that has been addressed yet, and a performant SCTP
> is still some ways away (though I'm sure Jon and Sridhar will be
> working their tails off to do so  ;)).

I wasn't aware of the current status.  Ok, that's just where it's at.

>
> But dont expect SCTP to be the surreptitious underlying layer
> carrying TCP traffic, if thats an expectation that anyone has :)

That's my particular kind of crazy idea.

>
> Solving this problem without application involvement is a
> more limited scenario..

Indeed.

>
> thanks,
> Nivedita
>
>

Andrew
