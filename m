Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUD3VKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUD3VKD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 17:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbUD3VHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 17:07:30 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:64527 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261179AbUD3VGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 17:06:09 -0400
Message-ID: <4092C0DF.1070001@techsource.com>
Date: Fri, 30 Apr 2004 17:10:55 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Marc Boucher <marc@linuxant.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       "'Sean Estabrooks'" <seanlkml@rogers.com>,
       "'Paul Wagland'" <paul@wagland.net>, "'Rik van Riel'" <riel@redhat.com>,
       "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "'Peter Williams'" <peterw@aurema.com>, Hua Zhong <hzhong@cisco.com>,
       "'lkml - Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       koke@sindominio.net, "'Rusty Russell'" <rusty@rustcorp.com.au>,
       "'David Gibson'" <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <009701c42edf$25e47390$ca41cb3f@amer.cisco.com> <Pine.LNX.4.58.0404301212070.18014@ppc970.osdl.org> <90DD8A88-9AE2-11D8-B83D-000A95BCAC26@linuxant.com> <Pine.LNX.4.58.0404301319020.18014@ppc970.osdl.org> <69A8B470-9AE6-11D8-B83D-000A95BCAC26@linuxant.com> <Pine.LNX.4.58.0404301343140.18014@ppc970.osdl.org> <6238ED6D-9AE8-11D8-B83D-000A95BCAC26@linuxant.com>
In-Reply-To: <6238ED6D-9AE8-11D8-B83D-000A95BCAC26@linuxant.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marc Boucher wrote:
> 
> 
> On Apr 30, 2004, at 4:44 PM, Linus Torvalds wrote:
> 
>>
>> The Linux-centric parts are absolutely NOT stand-alone, and one big part
>> of that Linux-centric stuff is that magic line that says 
>> MODULE_LICENSE().
>>
> 
> are you claiming that anything that uses the MODULE_LICENSE() macro 
> becomes a derived work of the Linux kernel subject to the GPL?


Well, some people might argue that, but let's put that aside for the 
moment.  I think one of the things he's implying is that anything which 
says MODULE_LICENSE("GPL") (which is what your driver did) is required 
to actually BE under the GPL.


Technically, since the Linux kernel headers are under GPL, including 
them into your code does make your code a derived work.  However, people 
are allowed to slide on this in certain strict circumstances, especially 
when MODULE_LICENSE doesn't say the license is GPL.

