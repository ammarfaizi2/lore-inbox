Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263523AbTLDVtP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 16:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263527AbTLDVtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 16:49:15 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:24030 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S263523AbTLDVtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 16:49:13 -0500
Date: Thu, 4 Dec 2003 13:48:50 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Message-ID: <20031204214850.GG29119@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Rob Landley <rob@landley.net>,
	linux-kernel@vger.kernel.org
References: <200312041432.23907.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312041432.23907.rob@landley.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 02:32:23PM -0600, Rob Landley wrote:
> You can make a file with a hole by seeking past it and never writing to that 
> bit, but is there any way to punch a hole in a file after the fact?  (I mean 
> other with lseek and write.  Having a sparse file as the result....)
> 

No, Linux doesn't have this feature.

> What are the downsides of holes?  (How big do they have to be to actually save 
> space, is there a performance penalty to having a file with 1000 4k holes in 
> it, etc...)

When you copy them, you need to use tools that know about sparse files and
how to deal with them.  Also, you will only save space on block aligned
contiguous zeros at least the length of one block.
