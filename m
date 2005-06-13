Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVFMMzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVFMMzi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 08:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVFMMzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 08:55:38 -0400
Received: from us401.activeby.net ([216.32.91.22]:62657 "EHLO
	us401.activeby.net") by vger.kernel.org with ESMTP id S261541AbVFMMyf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 08:54:35 -0400
Message-ID: <42AD81FC.9020404@active.by>
Date: Mon, 13 Jun 2005 15:54:20 +0300
From: Rommer <rommer@active.by>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Petrovitsch <bernd@firmix.at>
CC: =?ISO-8859-15?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>,
       linux-kernel@vger.kernel.org
Subject: Re: udp.c
References: <42AD74A3.1050006@active.by>	 <1118664180.898.13.camel@tara.firmix.at>	 <yw1xy89ebg14.fsf@ford.inprovide.com> <1118666058.898.23.camel@tara.firmix.at>
In-Reply-To: <1118666058.898.23.camel@tara.firmix.at>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - us401.activeby.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - active.by
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

So, why BUG(), not just void function?

Bernd Petrovitsch wrote:
> On Mon, 2005-06-13 at 14:24 +0200, Måns Rullgård wrote:
> 
>>Bernd Petrovitsch <bernd@firmix.at> writes:
>>
>>
>>>On Mon, 2005-06-13 at 14:57 +0300, Rommer wrote:
>>>
>>>>Where used strange function udp_v4_hash?
>>>>linux-2.6.11.11, net/ipv4/udp.c:204
>>>>
>>>>static void udp_v4_hash(struct sock *sk)
>>>
>>>Since it is "static" the user must be in the same source file (or -
>>>theoretically - any included header).
>>
>>It's not that simple.  It is assigned to the 'hash' field of a struct
> 
> 
> If you interpret "called" word-by-word yes. I assumed "used".
> 
> 
>>proto, which is exported.  It could be used from anywhere, but
> 
> 
> The the OP has to grep for dereferences for this hash variable and check
> if it is (or may be) from the given struct.
> Well, that's the virtue of object-orientation: Follow the objects, not
> the functions/methods.
> 
> 
>>hopefully isn't.  Something else is supposed to ensure that it is
>>never called when using the UDP protocol.
> 
> 
> Apparently.
> 
> 	Bernd

-- 
Best regards, Roman
