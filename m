Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264878AbTBFALr>; Wed, 5 Feb 2003 19:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264903AbTBFALr>; Wed, 5 Feb 2003 19:11:47 -0500
Received: from Xenon.Stanford.EDU ([171.64.66.201]:50822 "EHLO
	Xenon.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S264878AbTBFALq>; Wed, 5 Feb 2003 19:11:46 -0500
Date: Wed, 5 Feb 2003 16:21:16 -0800
From: Andy Chou <acc@CS.Stanford.EDU>
To: Greg KH <greg@kroah.com>
Cc: Andy Chou <acc@CS.Stanford.EDU>, linux-kernel@vger.kernel.org,
       mc@CS.Stanford.EDU
Subject: Re: [CHECKER] 112 potential memory leaks in 2.5.48
Message-ID: <20030206002116.GA9161@Xenon.Stanford.EDU>
References: <20030205011353.GA17941@Xenon.Stanford.EDU> <20030205234829.GB22101@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030205234829.GB22101@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the confirmation.  The checker may skip reporting some errors
if there are already other errors reported for a function.  But if only
one error is fixed, the other one will be "unmasked" and the checker will
warn about it.

-Andy

On Wed, Feb 05, 2003 at 03:48:29PM -0800, Greg KH wrote:
> On Tue, Feb 04, 2003 at 05:13:53PM -0800, Andy Chou wrote:
> > 7	|	drivers/hotplug/cpqphp_nvram.c
> 
> These were all real problems (and you missed one at the end, there was
> two places bus_node could be leaked like the other ones) and I've fixed
> them in my trees.
> 
> thanks,
> 
> greg k-h
