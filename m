Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265083AbUE0Tar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbUE0Tar (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 15:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265088AbUE0Tar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 15:30:47 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:24276 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265083AbUE0Tao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 15:30:44 -0400
Date: Thu, 27 May 2004 21:29:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@osdl.org>, davej@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP support for drain local pages v2.
Message-ID: <20040527192956.GD509@openzaurus.ucw.cz>
References: <40B473F7.4000100@linuxmail.org> <20040526223255.GB15278@redhat.com> <40B520A2.2060508@linuxmail.org> <20040526162607.0f177009.akpm@osdl.org> <40B52A7D.6090102@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B52A7D.6090102@linuxmail.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >But until something which needs this change is merged into the tree 
> >I'd say
> >that this patch should live with the patch which requires it.
> 
> CPU hotplugging uses drain_local_pages, and shouldn't drain the pcp 
> lists for all cpus. That's why I left the original version alone.
> 
> I'm submitting it now in preparation for merging, but Pavel's work on 
> SMP support for swsusp should be using this too. (It's not, but it 
> should be).

drain_local_pages was there so that accounting is not
screwed by local pages. That should be non-issue for stopped cpus.

OTOH you are right that my swsusp with smp does not work
on my smp machine, and I do not yet know why.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

