Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269731AbUHZVnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269731AbUHZVnc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 17:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269724AbUHZVl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 17:41:26 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:7557 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S269690AbUHZVeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 17:34:02 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16686.22336.829096.678178@thebsh.namesys.com>
Date: Fri, 27 Aug 2004 01:33:52 +0400
To: Christophe Saout <christophe@saout.de>
Cc: Dmitry Baryshkov <mitya@school.ioffe.ru>, Hans Reiser <reiser@namesys.com>,
       Andrew Morton <akpm@osdl.org>, hch@lst.de,
       linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>, flx@namesys.com,
       torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <1093552692.13881.43.camel@leto.cs.pocnet.net>
References: <20040824202521.GA26705@lst.de>
	<412CEE38.1080707@namesys.com>
	<20040825152805.45a1ce64.akpm@osdl.org>
	<412D9FE6.9050307@namesys.com>
	<20040826014542.4bfe7cc3.akpm@osdl.org>
	<412DAC59.4010508@namesys.com>
	<1093548414.5678.74.camel@krustophenia.net>
	<20040826203017.GA14361@school.ioffe.ru>
	<1093552692.13881.43.camel@leto.cs.pocnet.net>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout writes:
 > Am Freitag, den 27.08.2004, 00:30 +0400 schrieb Dmitry Baryshkov:
 > 
 > > Another example: Can ext2/etx3/reiserfsv3/xfs be implemented as reiser4
 > > plugins? From Hans' words it seems so. If this is correct, then maybe
 > > reiser4 core should be updated to completely replace current VFS layer?
 > > Then it's a good point to create a branch (in old development model it
 > > would be 2.7, dunno for new :), replace VFS layer with reiser4 core, and
 > > rewrite all (or at least most used) FS as reiser4 plugins. Then
 > > everybody will be happy.
 > > 
 > > But this looks too good to be true. Perhaps I misunderstood Hans' words
 > > aboud 'new disk format', did I?
 > 
 > No. You can change the format the reiser4 storage tree is stored in. As
 > long as other filesystems don't use the same underlying storage tree
 > this is not possible.

Wrong, plugin is called just below entry point from the VFS to the
file-system back-end. It can use reiser4 tree, or any storage layer it
wants. Or none at all: think about pseudo-files like
foo/metas/uid---they are also implemnted by plugins.

Programmer dedicated enough can (besides programming Fortran in any
language), write reiser4 plugin for any file-system. I will leave
description of this activity to people with better command over English
language.

Nikita.

 > 
