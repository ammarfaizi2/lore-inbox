Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbVH3RVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbVH3RVZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 13:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVH3RVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 13:21:25 -0400
Received: from mirapoint2.brutele.be ([212.68.199.149]:5984 "EHLO
	mirapoint2.brutele.be") by vger.kernel.org with ESMTP
	id S932152AbVH3RVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 13:21:24 -0400
Date: Tue, 30 Aug 2005 19:21:15 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Stephane Wirtel <stephane.wirtel@belgacom.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.13 - 1/3 - Remove the deprecated function __check_region
Message-ID: <20050830172115.GA11784@localhost.localdomain>
References: <20050830170502.GA10694@localhost.localdomain> <9a874849050830101743c421db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <9a874849050830101743c421db@mail.gmail.com>
X-Operating-System: Linux debian 2.6.12-1-k7
User-Agent: Mutt/1.5.10i
X-Junkmail-Status: score=10/50, host=mirapoint2.brutele.be
X-Junkmail-SD-Raw: score=unknown, refid=0001.0A090203.431492B1.0024-F-L0BeBC04zsV01UPbcJcIKw==,  =?ISO-8859-1?Q?=20i?=
	=?ISO-8859-1?Q?p=3D=C0=F5=08=08?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tuesday 30 August 2005 a 19:08, Jesper Juhl ecrivait: 
> On 8/30/05, Stephane Wirtel <stephane.wirtel@belgacom.net> wrote:
> > Hi all,
> > 
> > Here is the first patch for kernel 2.6.13 from Linus tree.
> > 
> 
> Take it easy. Don't kill __check_region() unless you first convert all
> users of it.
> And by removing __check_region() you've just broken check_region() -
> There are still some drivers left that use check_region() and there's
> no reason to break them.
> 
> The right approach is to identify all users of
> check_region()/__check_region(), then submit patches to convert them
> to use request_region instead. *Then*, when there are no more
> in-kernel users left, submit patches to remove the deprecated
> functions.

I know, I did not check with check_region, I will check all users of
check_region and I hope to send a new patch in few days.

Thanks Jesper, 

-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>
                <stephane.wirtel@gmail.com>


