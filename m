Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263852AbTJQVzz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 17:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263853AbTJQVzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 17:55:55 -0400
Received: from intra.cyclades.com ([64.186.161.6]:26044 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263852AbTJQVzx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 17:55:53 -0400
Date: Fri, 17 Oct 2003 18:58:42 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LVM Snapshots
In-Reply-To: <20031017161801.140b8368.Christoph.Pleger@uni-dortmund.de>
Message-ID: <Pine.LNX.4.44.0310171857370.12627-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 Oct 2003, Christoph Pleger wrote:

> ello,
> 
> On Fri, 17 Oct 2003 09:12:30 -0200 (BRST)
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> 
> 
> > > > I am using a 2.4.22 kernel from www.kernel.org together with an
> > > > XFS patch from SGI. I want to use LVM for creating snapshots for
> > > > backups, but I found out that I cannot mount the snapshots of
> > > > journalling filesystems (EXT3, XFS, Reiser). Only JFS snapshots
> > > > can be mounted. My research on internet gave the result that a
> > > > kernel-patch must be used to solve that problem, but I could not
> > > > find such a patch for Linux 2.4.22, so where can I get it?
> > > 
> > > Marcelo decided not to apply that needed patch. Here it is for you
> > > to play with :) ... It'll apply with offsets to 2.4.23-pre7.
> > 
> > Because the patch touches generic fs code.
> > 
> > Dont use LVM with XFS for now.
> 
> I have used them together. The only thing that made problems at first
> after applying the LVM-patch was that I did not know that the special
> option "nouuid" is needed when mounting an XFS-Snapshot. But afterwards
> I had no problem so far. 
> 
> So why do you think that I should not use XFS on a logical volume?

Because the filesystem code lacks locking somewhere (thats what the 
patches adds). 

It seems its not safe to create snapshots of journalled fs'es without this
patch.

