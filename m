Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbVERUD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbVERUD4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 16:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbVERUD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 16:03:56 -0400
Received: from chaos.egr.duke.edu ([152.3.195.82]:9668 "EHLO
	chaos.egr.duke.edu") by vger.kernel.org with ESMTP id S262335AbVERUCW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 16:02:22 -0400
Date: Wed, 18 May 2005 16:00:08 -0400 (EDT)
From: Joshua Baker-LePain <jlb17@duke.edu>
X-X-Sender: jlb@chaos.egr.duke.edu
To: Jakob Oestergaard <jakob@unthought.net>
cc: Chris Wedgwood <cw@f00f.org>, Gregory Brauer <greg@wildbrain.com>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: kernel OOPS for XFS in xfs_iget_core (using NFS+SMP+MD)
In-Reply-To: <20050518195251.GY422@unthought.net>
Message-ID: <Pine.LNX.4.58.0505181556410.6834@chaos.egr.duke.edu>
References: <428511F8.6020303@wildbrain.com> <20050514184711.GA27565@taniwha.stupidest.org>
 <428B7D7F.9000107@wildbrain.com> <20050518175925.GA22738@taniwha.stupidest.org>
 <20050518195251.GY422@unthought.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2005 at 9:52pm, Jakob Oestergaard wrote

> On Wed, May 18, 2005 at 10:59:25AM -0700, Chris Wedgwood wrote:
> > On Wed, May 18, 2005 at 10:38:07AM -0700, Gregory Brauer wrote:
> > 
> > > May 18 02:59:47 violet kernel: xfs_iget_core: ambiguous vns: vp/0xf53f8ac8, invp/0xe49ccc4c
> > 
> > I'm pretty sure it's NFS that aggravates this --- can anyone recall
> > why?
> 
> Not why no - but there where *major* problems with SMP+NFS+XFS up until
> 2.6.11.
> 
> I run 2.6.11(.8/9) on both SMP (dual athlon) and NUMA (64 bit kernel on
> dual opteron) with NFS and XFS and haven't yet seen any problems (knock
> the wood).
> 
> Seriously, any 2.6 earlier than .11 is *unusable* for file serving over
> NFS (at least with XFS which at the moment is the only FS with
> journalled quota so at least for me that's the only option).

Do you have a test case that would show this up?  I've been testing a 
centos-4 based server with the RH-derived 2.6.9-based kernel tweaked to 
disable 4K stacks and enable XFS and haven't run into any issues yet.  
This includes running the parallel IOR benchmark from 10 clients (and 
getting 200MiB/s throughput on reads).

-- 
Joshua Baker-LePain
Department of Biomedical Engineering
Duke University
