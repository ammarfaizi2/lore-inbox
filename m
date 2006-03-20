Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbWCTUN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWCTUN1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 15:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbWCTUN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 15:13:26 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:38810 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030186AbWCTUNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 15:13:25 -0500
Date: Mon, 20 Mar 2006 14:13:13 -0600
From: Mark Maule <maule@sgi.com>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, akpm@osdl.org,
       j-nomura@ce.jp.nec.com
Subject: Re: [PATCH 2.6.16-rc6-mm1] fix ia64 MSI build problems
Message-ID: <20060320201313.GM31238@sgi.com>
References: <20060320193638.GH31238@sgi.com> <20060320195415.GA17263@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320195415.GA17263@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 11:54:15AM -0800, Greg KH wrote:
> On Mon, Mar 20, 2006 at 01:36:38PM -0600, Mark Maule wrote:
> > Fix MSI-related build problems on ia64.
> > 
> > Move arch/ia64/sn/pci/msi.c to drivers/pci/msi-altix.c
> > Move struct msi_ops in drivers/pci/msi.h to the top of the file so asm/msi.h
> >     can make use of the declaration.
> > Clean up msi platform defintions in machvec.h (thanks to j-nomura@ce.jp.nec.com
> >     for the patch to do that).
> > 
> > Signed-off-by: Mark Maule <maule@sgi.com>
> 
> Does this replace any of your pre-existing msi patches in my tree (and
> in -mm)?  Shouldn't you just merge a few of them together now so that if
> someone were to apply stuff in order, the build is not broken for any
> step along the patch trail?

This patch just sits on top of the existing patchset.

> 
> And also, the Makefile should be changed as Matthew pointed out.
> 
> So, care to redo this?

Ok.  I'll give it a bit of time for other potential comments to roll in
and then redo the original patchset.

Mark
