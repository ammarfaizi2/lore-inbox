Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbUEFNGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbUEFNGJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 09:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbUEFNGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 09:06:09 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:6612 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S262132AbUEFNGB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 09:06:01 -0400
Message-ID: <409A3837.2060509@free.fr>
Date: Thu, 06 May 2004 15:05:59 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040501
X-Accept-Language: en
MIME-Version: 1.0
To: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: RE : 2.6.6-rc3-mm2 : REGPARAM forced => no external module with
 some object code only
References: <4098D65D.9010107@free.fr> <20040505131809.10bdcae6.akpm@osdl.org> <20040506124454.GA12921@babylon.d2dc.net>
In-Reply-To: <20040506124454.GA12921@babylon.d2dc.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zephaniah E. Hull wrote:
> On Wed, May 05, 2004 at 01:18:09PM -0700, Andrew Morton wrote:
> 
>>Eric Valette <eric.valette@free.fr> wrote:
>>
>>>The Changelog says nothing really important but forcing REGPARAM is 
>>> rather important : it breaks any external module using object only code 
>>> that calls a kernel function.
>>
>>This is why we should remove the option - to reduce the number of ways in
>>which the kernel might have been built.  Yes, there will be a bit of
>>transition pain while these people catch up.
> 
> 
> Any guess on when REGPARAM and 4KSTACKS will end up in Linus' tree?
> (Of interest because people may not consider it that important until
> they know it really is going to bite them.)

Well, may I suggest that the impact on end users is absolutely not the 
same :
	- 4KSTACKS only bites people that use badly written drivers allocating 
a lot of local variables on the stack (Nvidia, ...) and the availiable 
stack using this config is (from what I've read on this list) roughly 
equivalent to what is availiable in 2.4 series...
	- REGPARAM kills any driver whith object only file containing system calls,

Concerning the number of ways the kernel is compiled, I think that the 
number of GCC version produce even more debugging path than theses 
options. I really wonder if this is not a tactical game to push hardware 
manufacturer. But beware it could strike back because some supplier may 
just give up if they have to work on their driver even on stable series...


-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr



