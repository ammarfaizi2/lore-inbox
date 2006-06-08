Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWFHD7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWFHD7M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 23:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWFHD7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 23:59:12 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:53912 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932274AbWFHD7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 23:59:11 -0400
Date: Wed, 7 Jun 2006 23:59:10 -0400
From: Amy Griffis <amy.griffis@hp.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, John McCutchan <john@johnmccutchan.com>,
       Robert Love <rlove@rlove.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] inotify: split kernel API from userspace support
Message-ID: <20060608035910.GA1969@zk3.dec.com>
References: <20060601150702.GA2171@zk3.dec.com> <20060602123234.GA6586@zk3.dec.com> <20060606210619.GE4044@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060606210619.GE4044@ucw.cz>
X-Mailer: Mutt http://www.mutt.org/
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:     [Tue Jun 06 2006, 05:06:19PM EDT]
> > Here is a more descriptive changelog message for this patch:
> > 
> > This patch introduces a kernel API for inotify, making it possible for
> > kernel modules to benefit from inotify's mechanism for watching
> > inodes.
> 
> What are proposed uses of this API?

Currently there are two uses of this API.

The first user is the code that provides inotify support to userspace,
which lives in inotify_user.c in this patch.

The second user is an audit patch which provides path-based rules via
inotify directory events.  An inotify kernel API allows audit to take
advantage of inotify's hooks, list management, and inode removal
handling, instead of duplicating that functionality.

I'll send the audit patch in a new thread.

Amy
