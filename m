Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267433AbTA3IHi>; Thu, 30 Jan 2003 03:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267441AbTA3IHi>; Thu, 30 Jan 2003 03:07:38 -0500
Received: from users.linvision.com ([62.58.92.114]:34972 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S267433AbTA3IHh>; Thu, 30 Jan 2003 03:07:37 -0500
Date: Thu, 30 Jan 2003 09:16:54 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Takeshi Kodama <kodama@flab.fujitsu.co.jp>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why doesn't kernel store ICMP redirect in the routing tables?
Message-ID: <20030130091654.A22118@bitwizard.nl>
References: <008401c2c821$8af20cf0$c1a5190a@png.flab.fujitsu.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008401c2c821$8af20cf0$c1a5190a@png.flab.fujitsu.co.jp>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2003 at 02:36:30PM +0900, Takeshi Kodama wrote:
> Hello.
> 
> I run kernel-2.4.18. 
> When kernel receives ICMP redirect message, only store ICMP redirect in the route cache,
> not in the routeing tables.
> I have a question.
> 
> Why doesn't kernel store ICMP redirect in the routing tables?
> 
> In kernel-2.4.18, when new route is added(or existed route is deleted)
> and route become old, kernel flushs the route cache.
> If kernel doesn't store ICMP redirect in the routing tables,
> kernel will send packet to wrong gateway whenever flush the route cache.
> 
> Is it no matter that it generates ICMP redirect every time flush the route cache?  
> 
> Please tell me why kernel has such a specification that doesn't store ICMP redirect
> in the routing tables.

In your case, apparently the (static) routing info  changes every now 
and then, and you see the redirects getting flushed. In another case, 
the "redirect" may become invalidated, and if the kernel would have
put the redirect into the routing table, the system would not
recover, and keep on sending packets to the wrong router. 

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currently in such an      * 
* excursion: The stable situation does not include humans. ***************
