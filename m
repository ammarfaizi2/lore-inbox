Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265084AbUD3Ifr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265084AbUD3Ifr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 04:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265110AbUD3Ifr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 04:35:47 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:27471 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265084AbUD3Ifq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 04:35:46 -0400
Message-ID: <4091FD2C.7010307@yahoo.com.au>
Date: Fri, 30 Apr 2004 17:15:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Connors <tconnors+linuxkernel1083305837@astro.swin.edu.au>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, brettspamacct@fastclick.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <40904A84.2030307@yahoo.com.au> <200404292001.i3TK1BYe005147@eeyore.valparaiso.cl> <slrn-0.9.7.4-14292-10175-200404301617-tc@hexane.ssi.swin.edu.au> <4091F38C.3010400@yahoo.com.au> <Pine.LNX.4.53.0404301646510.11320@tellurium.ssi.swin.edu.au>
In-Reply-To: <Pine.LNX.4.53.0404301646510.11320@tellurium.ssi.swin.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Connors wrote:
> On Fri, 30 Apr 2004, Nick Piggin wrote:
> 
>>In our memory manager, there is a point where often used
>>"file cache" (ie. unmapped cache) is considered preferable
>>to unused or little used "application memory" (mapped
>>memory).
> 
> 
> Sure - and indeed I have current swap usage (now that I am not doing
> anything) of 300MB - that's good because I am not using whatever's in
> there.
> 
> 
>>I missed the description of your exact problem... was it in
>>this thread somewhere? Testing 2.6 would be appreciated if
>>possible too.
> 
> 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0404.3/1033.html
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0404.3/1394.html
> 
> In short: I have 512MB RAM. The files I am reading are read over NFS,

Ah, thanks for the description.

2.6 has a problem with NFS filesystems that would cause symptoms
like yours. I'm not sure whether 2.4 has something similar or not.
You can probably expect a fix for 2.6.6 but I'm not sure if there
is a patch that has been agreed upon yet.

In short, there probably isn't much point testing 2.6 right now.
