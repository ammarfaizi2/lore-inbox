Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265234AbUHVCOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbUHVCOo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 22:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265249AbUHVCO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 22:14:29 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:45201 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265234AbUHVCON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 22:14:13 -0400
Message-ID: <412800D6.3070207@yahoo.com.au>
Date: Sun, 22 Aug 2004 12:11:34 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@engr.sgi.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       John Hawkes <hawkes@sgi.com>
Subject: Re: 2.6.8.1-mm3
References: <20040820031919.413d0a95.akpm@osdl.org> <4126A4DC.1050103@yahoo.com.au> <200408211605.50975.jbarnes@engr.sgi.com> <200408211827.46591.jbarnes@engr.sgi.com>
In-Reply-To: <200408211827.46591.jbarnes@engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> On Saturday, August 21, 2004 1:05 pm, Jesse Barnes wrote:
> 
>>On Friday, August 20, 2004 9:26 pm, Nick Piggin wrote:
>>
>>>Jesse Barnes wrote:
>>>
>>>>On Friday, August 20, 2004 6:19 am, Andrew Morton wrote:
>>>>
>>>>>- This is (very) lightly tested.  Mainly a resync with various parties.
>>>>
>>>>Woo-hoo!  This boots *without changes* on a 512p Altix!  Now to re-run
>>>>the profiles and try wli's new per-cpu profiling buffers.
>>>
>>>What changes were needed to achieve this previously?
>>
>>The arch specific SD_NODE_INIT was the missing piece from previous -mm
>>releases.  Now that it's there, things seem to work.  I still have to poke
>>around to see if there are places where we're trying to scan across all
>>CPUs looking for busy ones and *then* checking to see if they're in a
>>domain. John said he'd take a closer look.
> 
> 
> It looks like the group span code will still try to look at everything in the 
> system.  That'll also have to be fixed to use the span from the associated 
> node's domain, since it looks like there are still places where we'll walk 
> all the CPUs in the system if it's not.  I'll take a closer look and see if I 
> can come up with something useful.
> 

I don't see it - what function are you talking about?
