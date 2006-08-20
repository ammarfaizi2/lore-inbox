Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWHTKIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWHTKIV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 06:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWHTKIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 06:08:21 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:41185 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750705AbWHTKIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 06:08:20 -0400
Date: Sun, 20 Aug 2006 12:07:06 +0200
From: fork0@t-online.de (Alex Riesen)
To: Solar Designer <solar@openwall.com>
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
Message-ID: <20060820100706.GB6003@steel.home>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mail-Followup-To: Alex Riesen <fork0@users.sourceforge.net>,
	Solar Designer <solar@openwall.com>,
	Willy Tarreau <wtarreau@hera.kernel.org>,
	linux-kernel@vger.kernel.org
References: <20060820003840.GA17249@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820003840.GA17249@openwall.com>
User-Agent: Mutt/1.5.11
X-ID: rAvcL8Z1ZeILaO+QbJzflO1Kq6J7o1Bb4Inf3rYCAzUZ2UT4lZyBwK
X-TOI-MSGID: 1e9d2093-a4cd-4244-b3c3-65c058dcaa82
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Solar Designer, Sun, Aug 20, 2006 02:38:40 +0200:
> Willy and all,
> 
> Attached is a trivial patch (extracted from 2.4.33-ow1) that makes
> set*uid() kill the current process rather than proceed with -EAGAIN when
> the kernel is running out of memory.  Apparently, alloc_uid() can't fail
> and return anyway due to properties of the allocator, in which case the
> patch does not change a thing.  But better safe than sorry.

Why not ENOMEM?

