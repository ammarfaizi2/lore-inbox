Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbWARAmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbWARAmu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbWARAmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:42:50 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:41694 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964982AbWARAmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:42:47 -0500
Date: Wed, 18 Jan 2006 09:42:21 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [discuss] [PATCH/RFC] Unify mapping from PXM to node id.
Cc: discuss@x86-64.org, ACPI-ML <linux-acpi@vger.kernel.org>,
       linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       "Luck, Tony" <tony.luck@intel.com>, "Brown, Len" <len.brown@intel.com>
In-Reply-To: <200601171505.32933.ak@suse.de>
References: <20060117205442.5B9A.Y-GOTO@jp.fujitsu.com> <200601171505.32933.ak@suse.de>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.057
Message-Id: <20060118094209.019D.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tuesday 17 January 2006 13:36, Yasunori Goto wrote:
> > Hello.
> >
> > This patch is to unify mapping from pxm to node id as a common code.
> > In current code, i386, x86-64, and ia64 have its mapping by each own code.
> > But PXM is defined by ACPI and node id is used generically. So,
> > I think there is no reason to define it on each arch's code.
> > This mapping should be written at drivers/acpi/numa.c.
> >
> 
> > Please comment.
> 
> The array is unnecessary big - PXMs are only 8bit so it could be u8.
> 
> Looks ok to me on x86-64 in principle, except that the __devinits should
> be probably __cpuinits. I haven't tested/compiled it though

Ok. I'll modify them, and test it on x86-64 too.
Thanks for your comment.

-- 
Yasunori Goto 


