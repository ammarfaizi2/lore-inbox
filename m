Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbTJ3IRm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 03:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbTJ3IRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 03:17:42 -0500
Received: from home.wiggy.net ([213.84.101.140]:30364 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S262253AbTJ3IRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 03:17:41 -0500
Date: Thu, 30 Oct 2003 09:17:39 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right
Message-ID: <20031030081739.GB1399@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3F9F7F66.9060008@namesys.com> <20031029224230.GA32463@codepoet.org> <20031030015212.GD8689@thunk.org> <3FA0C631.6030905@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA0C631.6030905@namesys.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Hans Reiser wrote:
> It is true that there are many features, such as an automatic text 
> indexer, that belong in user space, but the basic indexes (aka 
> directories) and index traversal code belong in the kernel.

Sure, but if you have a kernel which supports arbitraty extended
attributes for files you don't need much more kernel support. You
can implement things like metadata for files and query languages on
top of that in userspace. If you modify applications to (also) put some
metadata (meta tags from html pages, document properties from office
documents, etc.) in those extended attributes you might already be where
microsoft is going.

You only would need some kernel interaction if you want to keep an
updated index of file contents (dnotify for a while filesystem and
reindexing whole files instead of blocks doesn't sound very attractive).

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.

