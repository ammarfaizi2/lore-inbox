Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbVHEWPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbVHEWPX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 18:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVHEWNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 18:13:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28808 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261947AbVHEWL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 18:11:28 -0400
Date: Fri, 5 Aug 2005 15:10:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcapatcch equivalent?
Message-Id: <20050805151017.745f4188.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508051157590.22353@skynet>
References: <Pine.LNX.4.58.0508051157590.22353@skynet>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie <airlied@linux.ie> wrote:
>
> 
> At KS I asked after a gcapatch command for git..
> 
> I've got two trees drm-2.6 and linux-2.6, linux-2.6 is latest Linus, so of
> course a tree diff gives me all the new patches in linux-2.6 that aren't
> in drm-2.6 which isn't what I want.. I want gcapatch....
> 
> I'm sure someone has one and I don't really want to care about git
> internals :-)

I do this, which mostly works:

	MERGE_BASE=$(git-merge-base $(cat .git/refs/heads/origin ) \
				$(cat .git/refs/heads/$patch_name))

	cg-diff -r $MERGE_BASE:$(cat .git/refs/heads/$patch_name) >> \
				$PULL/$patch_name.patch

(I'm supposed to be doing real git merges of 40 trees and let git do more
work for me.  I'll do that when I'm feeling really, really trusting).
