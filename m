Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbWBLVZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWBLVZH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 16:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbWBLVZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 16:25:06 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:25047 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751448AbWBLVZF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 16:25:05 -0500
Date: Sun, 12 Feb 2006 21:25:04 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linda Walsh <lkml@tlinx.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: max symlink = 5? ?bug? ?feature deficit?
Message-ID: <20060212212504.GX27946@ftp.linux.org.uk>
References: <43ED5A7B.7040908@tlinx.org> <20060212180601.GU27946@ftp.linux.org.uk> <43EFA63B.30907@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EFA63B.30907@tlinx.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2006 at 01:18:51PM -0800, Linda Walsh wrote:
> Al Viro wrote:
> >>Should it be something like Glib's '20' or '255'?
> >>    
> >	20 or 255 - not feasible (we'll get stack overflow from hell).
> >  
> How much stack is used/iteration?  It appears we have a local pointer in
> __do_follow_link, and 2 passed parameters/call + call-returns ->5
> pointers/iteration.  "Forty" entries would seem to take 200 pointers or
> 800 bytes of stack space?  A limit of 20 would use 400 bytes?

Care to RTFS?  I mean, really - at least to the point of seeing what's
involved in that recursion.
