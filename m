Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751959AbWAEFyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbWAEFyw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 00:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbWAEFyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 00:54:52 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:36030 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751959AbWAEFyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 00:54:51 -0500
Date: Thu, 05 Jan 2006 14:54:25 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: jschopp@austin.ibm.com
Subject: Re: [Patch] New zone ZONE_EASY_RECLAIM take 4. (Change PageHighMem())[8/8]
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
In-Reply-To: <43BAEF69.3020006@austin.ibm.com>
References: <20051220173217.1B18.Y-GOTO@jp.fujitsu.com> <43BAEF69.3020006@austin.ibm.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.057
Message-Id: <20060105144337.491F.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This patch is change PageHighMem()'s definition for i386.
> > Easy reclaim zone is treated like highmem on i386.
> 
> This doesn't look like an i386 file, it looks like you are changing it 
> for all architectures that have HIGHMEM (do any other archs use 
> highmeme?). This may be fine, just wanted you to be aware.

Right. My description was wrong. This is for all arch.

The first purpose of his patch is to give i386 environment for
Kame-san's remove patch. This description came from it.

Sorry.



> 
> > 
> > This is new patch at take 4.
> > 
> > Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>
> > 
> > Index: zone_reclaim/include/linux/page-flags.h
> > ===================================================================
> > --- zone_reclaim.orig/include/linux/page-flags.h	2005-12-15 21:01:09.000000000 +0900
> > +++ zone_reclaim/include/linux/page-flags.h	2005-12-15 21:24:07.000000000 +0900
> > @@ -265,7 +265,7 @@ extern void __mod_page_state_offset(unsi
> >  #define TestSetPageSlab(page)	test_and_set_bit(PG_slab, &(page)->flags)
> >  
> >  #ifdef CONFIG_HIGHMEM
> > -#define PageHighMem(page)	is_highmem(page_zone(page))
> > +#define PageHighMem(page)	is_higher_zone(page_zone(page))
> >  #else
> >  #define PageHighMem(page)	0 /* needed to optimize away at compile time */
> >  #endif
> > 
> 
> 

-- 
Yasunori Goto 


