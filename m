Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270199AbRH1DWL>; Mon, 27 Aug 2001 23:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270178AbRH1DWB>; Mon, 27 Aug 2001 23:22:01 -0400
Received: from james.kalifornia.com ([208.179.59.2]:31294 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S270201AbRH1DVu>; Mon, 27 Aug 2001 23:21:50 -0400
Message-ID: <3B8B0E60.9030604@blue-labs.org>
Date: Mon, 27 Aug 2001 23:22:08 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010826
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Neulinger <nneul@umr.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Blocking bind to outbound interface?
In-Reply-To: <3B8AFA81.6B10190C@umr.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use iproute2.

ip route add <network> via <router> src <preferred interface address>

Of course you could more easily make this public IP the primary address 
on the interface and the private IP secondary...

There are actually a few ways to skin this cat.

-d

Nathan Neulinger wrote:

>Is there any way to block use of an interface for outbound connections?
>
>I have a host who's primary outbound interface is on a private network
>(using a private address block for our backbone). Unfortunately, this
>means that most applications (those not providing an option to select
>bind address) will bind to this private-net address when establishing
>outbound connections or sending udp packets.
>
>The host has another address which is a publically accessible ip, but
>it's not the default route interface.
>
>Is there any way to hide this interface on the host for ALL outbound
>connections without modifying all applications/app invocations? Or some
>way of overriding the mechanism for selection of default interface.
>
>-- Nathan
>
>------------------------------------------------------------
>Nathan Neulinger                       EMail:  nneul@umr.edu
>University of Missouri - Rolla         Phone: (573) 341-4841
>CIS - Systems Programming                Fax: (573) 341-4216
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


-- 
>:>
I may have the information you need and I may choose only HTML.  It's up to you.



