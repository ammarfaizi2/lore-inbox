Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbWFHUNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbWFHUNx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 16:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWFHUNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 16:13:53 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20498 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S964973AbWFHUNw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 16:13:52 -0400
Date: Thu, 8 Jun 2006 20:13:36 +0000
From: Pavel Machek <pavel@suse.cz>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>, Don Zickus <dzickus@redhat.com>,
       ak@suse.de, shaohua.li@intel.com, miles.lane@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
Message-ID: <20060608201336.GD4006@ucw.cz>
References: <4480C102.3060400@goop.org> <20060606230504.GC11696@redhat.com> <20060606162201.f0f9f308.akpm@osdl.org> <200606070938.34927.ncunningham@linuxmail.org> <44861899.1040506@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44861899.1040506@goop.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> But the problem is that there's nothing which keeps 
> track of whether the re-plugged cpus 1-N are the "same" 
> as the unplugged 1-N, and so nothing can apply the same 
> per-cpu settings to them.  In the suspend/resume case 
> they clearly are, but in the general remove/add case, do 
> you really want the new CPU to get the same state as the 
> old one just because it ends up with the same logical 
> CPU number?  Perhaps, but what if it doesn't even have 
> the same capabilities? 

> (Do we support heterogeneous 
> CPUs anyway?)

It works for some people, but it certainly falls into unsupported
category.

-- 
Thanks for all the (sleeping) penguins.
