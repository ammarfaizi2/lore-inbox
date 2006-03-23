Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWCWB6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWCWB6m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 20:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWCWB6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 20:58:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24041 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932342AbWCWB6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 20:58:41 -0500
Date: Wed, 22 Mar 2006 17:55:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Valerie Henson <val_henson@linux.intel.com>
Cc: pbadari@gmail.com, linux-kernel@vger.kernel.org,
       Ext2-devel@lists.sourceforge.net, arjan@linux.intel.com, tytso@mit.edu,
       zach.brown@oracle.com
Subject: Re: [Ext2-devel] [RFC] [PATCH] Reducing average ext2 fsck time
 through fs-wide dirty bit]
Message-Id: <20060322175503.3b678ab5.akpm@osdl.org>
In-Reply-To: <20060322224844.GU12571@goober>
References: <20060322011034.GP12571@goober>
	<1143054558.6086.61.camel@dyn9047017100.beaverton.ibm.com>
	<20060322224844.GU12571@goober>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valerie Henson <val_henson@linux.intel.com> wrote:
>
> On Wed, Mar 22, 2006 at 11:09:18AM -0800, Badari Pulavarty wrote:
> > On Tue, 2006-03-21 at 17:10 -0800, Valerie Henson wrote:
> > > Hi all,
> > > 
> > > I am working on reducing the average time spent on fscking ext2 file
> > > systems.  My initial take on the problem is to avoid fscking when the
> > 
> > Just curious, why are you teaching ext2 same tricks that are in ext3 ?
> > Is there a reason behind improving ext2 ? Are there any benefits
> > of not using ext3 instead ?
> 
> ext2 is simpler and faster than ext3 in many cases.  This is sort of
> cheating; ext2 is simpler and faster because it makes no effort to
> maintain on-disk consistency and can skip annoying things like, oh,
> reserving space in the journal.  I am looking for ways to make ext2
> cheat even more.
> 

But it might be feasible to knock up an ext3-- in which all the journal
operations are stubbed out.

