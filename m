Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263457AbREXXuS>; Thu, 24 May 2001 19:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263456AbREXXuJ>; Thu, 24 May 2001 19:50:09 -0400
Received: from 216-21-153-1.ip.van.radiant.net ([216.21.153.1]:33805 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S263455AbREXXuB>;
	Thu, 24 May 2001 19:50:01 -0400
Date: Thu, 24 May 2001 16:51:46 -0700 (PDT)
From: Gerhard Mack <gmack@innerfire.net>
To: Bharath Madhavan <bharath_madhavan@ivivity.com>
cc: "'David S. Miller'" <davem@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Accelerated TCP/IP support from kernel
In-Reply-To: <25369470B6F0D41194820002B328BDD20717A0@ATLOPS>
Message-ID: <Pine.LNX.4.10.10105241651130.20366-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm curious.. do your cards support IPv6 and ECN ?

	Gerhard


On Thu, 24 May 2001, Bharath Madhavan wrote:

> Thanks a lot. That was useful info especially your last point
> where you are saying that most of the area we can save is in
> data processing and not in protocol processing.
> So, if we use the ZERO_COPY feature, we should gain quite a bit.
> I guess 3c905c NIC supports HW checksumming. Is this true?
> In this case, do we have any benchmarking for this card 
> with and without ZERO_COPY (and HW checksumming). I am eager to
> know by how many times did the system throughput increase?
> Thanks a lot
> Bharath
> 
> 
> 
> 
> -----Original Message-----
> From: David S. Miller [mailto:davem@redhat.com]
> Sent: Thursday, May 24, 2001 6:29 PM
> To: Bharath Madhavan
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Accelerated TCP/IP support from kernel
> 
> 
> 
> Bharath Madhavan writes:
>  > 	I am looking into a scenario where we have a NIC which performs 
>  > all the TCP/IP processing and basically the core CPU offloads all data
> from
>  > the socket level interface onwards to this NIC. 
> 
> Why would you ever want to do this?
> 
> Point 1: Support for new TCP techniques and bug fixes are hard enough
> to propagate to user's systems as it is with the implementation being
> done in software.
> 
> Point 2: If I find a bug in the cards TCP implementation, will I be
> able to get at the source for the firmware and fix it?  Likely the
> answer to this is no.
> 
> Every couple years a few vendors make cards like this, yet ignore
> these core issues.  It is currently impractical to use these kinds of
> cards today except in a few very special case situations.
> 
> Furthermore, the actual protocol processing overhead is quite small
> and almost neglible especially on today's gigahertz beasts.  The data
> copy is where the time is spent, and checksum offload takes care of
> that.
> 
> Later,
> David S. Miller
> davem@redhat.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

