Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275328AbTHGNhC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 09:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275314AbTHGNef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 09:34:35 -0400
Received: from angband.namesys.com ([212.16.7.85]:63157 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S275324AbTHGNeA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 09:34:00 -0400
Date: Thu, 7 Aug 2003 17:33:58 +0400
From: Oleg Drokin <green@namesys.com>
To: Hans Reiser <reiser@namesys.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6] reiserfs: fix locking in reiserfs_remount
Message-ID: <20030807133358.GC20639@namesys.com>
References: <20030806093858.GF14457@namesys.com> <20030806172813.GB21290@matchmail.com> <20030806173114.GB15024@namesys.com> <3F32531B.7080000@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F32531B.7080000@namesys.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Aug 07, 2003 at 05:24:43PM +0400, Hans Reiser wrote:

> >Reiserfs needs BKL for it's journal operations. This is not "more",
> >for some time BKL was taken in the VFS, then whoever removed that,
> >forgot to propagate BKL down to actual fs methods that need the BKL.
> Is it known who removed it?

I think it was Andrew. At least this new emergency remount path without
BKL was introduced by his patch without any extra attribution.

Bye,
    Oleg
