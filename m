Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752173AbWCNQcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbWCNQcp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 11:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752174AbWCNQcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 11:32:45 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:56774
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1752173AbWCNQco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 11:32:44 -0500
From: Rob Landley <rob@landley.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: How do I get the ext3 driver to shut up?
Date: Tue, 14 Mar 2006 11:32:58 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <200603132218.39511.rob@landley.net> <20060313231407.7606f0d3.akpm@osdl.org>
In-Reply-To: <20060313231407.7606f0d3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603141132.58814.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 March 2006 2:14 am, Andrew Morton wrote:
> Rob Landley <rob@landley.net> wrote:
> > I'm making a test suite for busybox mount, which does filesystem
> > autodetection the easy way (try all the ones in /etc/filesystems and
> > /proc/filesystems until one of them succeeds).  My test code is creating
> > and mounting vfat and ext2 filesystems.
> >
> >  Guess which device driver feels a bit chatty?
> >
> > ...
> >
> >  VFS: Can't find ext3 filesystem on dev loop0.
>
> That's only printed if the sys_mount() caller set MS_VERBOSE in `flags'.

Well, I didn't set it from userspace.  Stuck in a printf to make sure.

name /dev/loop0 vfsflags=0 0
VFS: Can't find ext3 filesystem on dev loop0.

Rob
-- 
Never bet against the cheap plastic solution.
