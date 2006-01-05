Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751954AbWAEFoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbWAEFoM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 00:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbWAEFoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 00:44:12 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:21423 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751954AbWAEFoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 00:44:11 -0500
Date: Thu, 05 Jan 2006 14:43:27 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: jschopp@austin.ibm.com
Subject: Re: [Patch] New zone ZONE_EASY_RECLAIM take 4. (disable gfp_easy_reclaim bit)[5/8]
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
In-Reply-To: <43BAEDDD.8080805@austin.ibm.com>
References: <20051220173013.1B10.Y-GOTO@jp.fujitsu.com> <43BAEDDD.8080805@austin.ibm.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.057
Message-Id: <20060105144247.491D.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > ===================================================================
> > --- zone_reclaim.orig/fs/pipe.c	2005-12-16 18:36:20.000000000 +0900
> > +++ zone_reclaim/fs/pipe.c	2005-12-16 19:15:35.000000000 +0900
> > @@ -284,7 +284,7 @@ pipe_writev(struct file *filp, const str
> >  			int error;
> >  
> >  			if (!page) {
> > -				page = alloc_page(GFP_HIGHUSER);
> > +				page = alloc_page(GFP_HIGHUSER & ~__GFP_EASY_RECLAIM);
> >  				if (unlikely(!page)) {
> >  					ret = ret ? : -ENOMEM;
> >  					break;
> 
> That is a bit hard to understand.  How about a new GFP_HIGHUSER_HARD or 
> somesuch define back in patch 1, then use it here?

It looks better. Thanks for your idea.

-- 
Yasunori Goto 


