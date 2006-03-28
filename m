Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbWC1Wsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWC1Wsh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWC1Wsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:48:37 -0500
Received: from mx2.netapp.com ([216.240.18.37]:40307 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S932485AbWC1Wsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:48:36 -0500
X-IronPort-AV: i="4.03,140,1141632000"; 
   d="scan'208"; a="370551607:sNHT24132748"
Subject: Re: [PATCH] config: Fix CONFIG_LFS option
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0603281430370.15714@g5.osdl.org>
References: <1143584319.8199.34.camel@lade.trondhjem.org>
	 <Pine.LNX.4.64.0603281430370.15714@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance, Inc
Date: Tue, 28 Mar 2006 17:48:34 -0500
Message-Id: <1143586114.8199.49.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-OriginalArrivalTime: 28 Mar 2006 22:48:35.0141 (UTC) FILETIME=[BEDFE750:01C652B9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 14:34 -0800, Linus Torvalds wrote:
> 
> On Tue, 28 Mar 2006, Trond Myklebust wrote:
> >
> > The help text says that if you select CONFIG_LBD, then it will
> > automatically select CONFIG_LFS. Nope... That isn't currently the
> > case.
> 
> I'm not sure your patch makes anything much better, though.
> 
> Why does CONFIG_LSF exist in the first place? Afaik, it only affects a 
> totally not-very-interesting thing (blkcnt_t) for a totally not very 
> interesting feature (the number of people who want single files >2TB is 
> likely not very big).
> 
> Having it auto-selected by LBD sounds insane, since LBD is likely more 
> interesting than LSF itsef is. It would make more sense to go the other 
> way (have LSF auto-select LBD).

NFSv3 and CIFS are two examples of commonly used filesystems that don't
care a hoot for CONFIG_LBD, but that still want to be able to support
large values for inode->i_blocks.

Cheers,
  Trond
