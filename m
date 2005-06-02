Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVFBV0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVFBV0L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 17:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVFBVZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 17:25:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18381 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261256AbVFBVOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 17:14:43 -0400
Date: Thu, 2 Jun 2005 17:12:50 -0400
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, mark.langsdorf@amd.com
Subject: Re: [2.6 patch] unexport phys_proc_id and cpu_core_id
Message-ID: <20050602211249.GB23826@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>, Andi Kleen <ak@suse.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	mark.langsdorf@amd.com
References: <20050506211913.GO3590@stusta.de> <20050507134507.GB30158@wotan.suse.de> <20050602204814.GJ4992@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050602204814.GJ4992@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 10:48:14PM +0200, Adrian Bunk wrote:
 > On Sat, May 07, 2005 at 03:45:07PM +0200, Andi Kleen wrote:
 > > On Fri, May 06, 2005 at 11:19:14PM +0200, Adrian Bunk wrote:
 > > > Back in January, Andi Kleen added EXPORT_SYMBOL(phys_proc_id), stating:
 > > >   This is needed for the powernow k8 driver to manage AMD dual core 
 > > >   systems.
 > > > 
 > > > This EXPORT_SYMBOL was never used.
 > > > 
 > > > I asked him on 13 Mar 2005 whether it's really required, but he didn't 
 > > > answer to my email.
 > > 
 > > It is superceeded now with cpu_core_map[]/cpu_core_id[]
 > > > 
 > > > 2.6.12-rc3 adds cpu_core_id with a similarly unused 
 > > > EXPORT_SYMBOL(cpu_core_id).
 > > > 
 > > > It's OK to export symbols when these exports are required, but unless 
 > > > someone can explain why they are required now, they should be removed 
 > > > before 2.6.12 and then re-added when they are actually used.
 > > 
 > > The dual powernowk8 driver really uses them, although the merging 
 > > process seems to be a bit slow.
 > > 
 > > Andrew, please don't apply the patch.
 > 
 > Is there any time when you expect to submit the dual powernowk8 driver 
 > you've added the EXPORT_SYMBOL for five months ago?
 > 
 > I'd prefer if we'd not add EXPORT_SYMBOL's before the potential users 
 > are available...
 
powernow-k8 dual-core support got merged a few days ago.

		Dave
