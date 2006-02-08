Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161085AbWBHPOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbWBHPOT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 10:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161086AbWBHPOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 10:14:19 -0500
Received: from 213-140-2-69.ip.fastwebnet.it ([213.140.2.69]:62592 "EHLO
	aa002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1161085AbWBHPOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 10:14:18 -0500
Date: Wed, 8 Feb 2006 16:15:05 +0100
From: Mattia Dongili <malattia@linux.it>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How in tarnation do I git v2.6.16-rc2?  hg died and I still don't git git
Message-ID: <20060208151504.GA10764@inferi.kami.home>
Mail-Followup-To: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
References: <20060208070301.1162e8c3.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208070301.1162e8c3.pj@sgi.com>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.16-rc1-mm5-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Feb 08, 2006 at 07:03:01AM -0800, Paul Jackson wrote:
> I'm trying to git a copy of Linus's tree, checked out only up
> through revision v2.6.16-rc2, so that I can lay down Andrew's
> latest broken-out quilt patch set for 2.6.16-rc2-mm1 on top of it.
[...]
> But how in tarnation do I git a checked out copy/clone/whatever of
> Linus's tree that only has the changes up through revision v2.6.16-rc2
> (that doesn't include changes since then)?

I usually create a branch for each -mm release and add there all the
patches, eg:
	git checkout -f -b v2.6.16-rc2-mm1 v2.6.16-rc2

then do something like:
	while [ $(quilt next) ] ; do \
		quilt push && git add && git commit -a -m "$(quilt top)"; \
	done

as an alternative you canprobably checkout HEAD and git-reset --hard to
the wanted commit.

hth
-- 
mattia
:wq!
