Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272388AbTHEC7V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 22:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272390AbTHEC7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 22:59:21 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:29714 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S272388AbTHEC6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 22:58:48 -0400
Date: Tue, 5 Aug 2003 04:58:46 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: i_blksize
Message-ID: <20030805025846.GA4779@win.tue.nl>
References: <UTC200308040203.h7423rv14876.aeb@smtp.cwi.nl> <20030803192919.0d7d881c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030803192919.0d7d881c.akpm@osdl.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03, 2003 at 07:29:19PM -0700, Andrew Morton wrote:

> and inode.i_blksize should probably be removed from the kernel.

I see that Linus has added a comment and does not want to rename,
so that settles that half of that letter.

You propose to remove i_blksize.
Yes, a good plan, half an hour's work.
It is used in stat only, so we have to produce some value for stat.
Do you want to replace
	inode->i_blksize
by
	inode->i_sb->s_optimal_io_size
?

Andries

