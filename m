Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262813AbSLMNOi>; Fri, 13 Dec 2002 08:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262804AbSLMNOi>; Fri, 13 Dec 2002 08:14:38 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:57301 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S262796AbSLMNOg>; Fri, 13 Dec 2002 08:14:36 -0500
Date: Sat, 14 Dec 2002 02:07:24 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
cc: "David S. Miller" <davem@redhat.com>, dlstevens@us.ibm.com,
       matti.aarnio@zmailer.org, niv@us.ibm.com, alan@lxorguk.ukuu.org.uk,
       stefano.andreani.ap@h3g.it, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: R: Kernel bug handling TCP_RTO_MAX?
Message-ID: <24420000.1039784844@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0212131321400.11129-100000@kenzo.iwr.uni-heidelberg.de>
References: <Pine.LNX.4.44.0212131321400.11129-100000@kenzo.iwr.uni-heidelbe
 rg.de>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Friday, December 13, 2002 13:33:16 +0100 Bogdan Costescu 
<bogdan.costescu@iwr.uni-heidelberg.de> wrote:

> On Sat, 14 Dec 2002, Andrew McGregor wrote:
>
>> You're going to make lots of IETFer's really annoyed by suggesting that
>> :-)
>
> I hope not. That was the reason for allowing it to be tuned and for
> having  a default value equal to the existing one.

I know the folks in question :-)  Actually, they'd be nice about it, but 
say something like:

Well, RFC 2988 says that the present value is too small and should be 1s, 
although I take it from other discussion that experiment shows 200ms to be 
OK.

Instead, RFCs 3042 and 3390 present the IETF's preferred approach that has 
actually made it through the process.  But there are lots of drafts in 
progress, so that isn't the final word, although it is certainly better 
than tuning down RTO_MAX.

Now, I have no idea if the kernel presently implements the latter two by 
default (and on a quick look I can't find either in the code).  If not, it 
should.  Shouldn't the initial window be a tunable?

>> In a closed network, why not have SOCK_STREAM map to something faster
>> than  TCP anyway?
>
> Sure, just give me a protocol that:
> - is reliable
> - has low latency
> - comes with the standard kernel
> and I'll just use it. But you always get only 2 out ot 3...
>
> --
> Bogdan Costescu

SCTP is in 2.5 now.  Does that not fit the bill?  I admit, I don't know 
about the reliability, although I guess I'm going to find out as I have 
cause to use it shortly.  Wearing an IETF hat, I'd like to hear about this, 
as I'm on a bit of a practicality crusade there :-)

Andrew
