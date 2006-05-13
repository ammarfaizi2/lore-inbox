Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWEMO4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWEMO4t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 10:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWEMO4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 10:56:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54468 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751227AbWEMO4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 10:56:48 -0400
Date: Sat, 13 May 2006 07:56:26 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Maneesh Soni <maneesh@in.ibm.com>
cc: Sachin Sant <sachinp@in.ibm.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Sharyathi Nagesh <sharyath@in.ibm.com>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>, Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: Bug while executing : cat /proc/iomem on 2.6.17-rc1/rc2
In-Reply-To: <20060513103047.GA28366@in.ibm.com>
Message-ID: <Pine.LNX.4.64.0605130755040.3866@g5.osdl.org>
References: <444DFD53.2000108@in.ibm.com> <1145962096.3114.19.camel@laptopd505.fenrus.org>
 <1147332468.17798.13.camel@localhost.localdomain> <20060511073205.GA28693@flint.arm.linux.org.uk>
 <4462F7F4.7050908@in.ibm.com> <20060513103047.GA28366@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 May 2006, Maneesh Soni wrote:
> 
> Backing out 
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=10dbe196a8da6b3196881269c6639c0ec11c36cb
> 
> solves this problem for me. This patch adds memory more than 4G to /proc/iomem
> but without 64-bit fields for struct resource it ends up in confusing 
> iomem_resource list. I think this patch needs the core 64-bit struct resource
> related changes also.

Yeah, let's revert that for now. I don't think the people involved 
realized how it was dependent on the 64-bit struct resource changes.

Thanks,

		Linus
