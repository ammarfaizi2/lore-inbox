Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbTEHNGw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 09:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbTEHNGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 09:06:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32921 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261524AbTEHNGv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 09:06:51 -0400
Date: Thu, 8 May 2003 14:19:26 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>, Jan Harkes <jaharkes@cs.cmu.edu>,
       lsm <linux-security-module@wirex.com>
Subject: Re: [PATCH] Process Attribute API for Security Modules 2.5.69
Message-ID: <20030508131926.GU10374@parcelfarce.linux.theplanet.co.uk>
References: <1052237601.1377.991.camel@moss-huskers.epoch.ncsc.mil> <20030507105038.GN10374@parcelfarce.linux.theplanet.co.uk> <1052319765.1044.60.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052319765.1044.60.camel@moss-huskers.epoch.ncsc.mil>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 11:02:46AM -0400, Stephen Smalley wrote:
> On Wed, 2003-05-07 at 06:50, viro@parcelfarce.linux.theplanet.co.uk
> wrote:
> > Umm...  How about having it merged with proc_base_readdir()?  I.e.
> > have both call the common helper.  Ditto for lookups.
> > 
> > Other than that (and missing check for copy_to_user() return value in
> > ->read()) I don't see any problems here.
> 
> This updated patch against 2.5.69 merges the readdir and lookup routines
> for proc_base and proc_attr, fixes the copy_to_user call in
> proc_attr_read and proc_info_read, moves the new data and code within
> CONFIG_SECURITY, and uses ARRAY_SIZE, per the comments from Al Viro and
> Andrew Morton.  As before, this patch implements a process attribute API
> for security modules via a set of nodes in a /proc/pid/attr directory.
> Credit for the idea of implementing this API via /proc/pid/attr nodes
> goes to Al Viro.  Jan Harkes provided a nice cleanup of the
> implementation to reduce the code bloat.

[snip]

Looks sane...
