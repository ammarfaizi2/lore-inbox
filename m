Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbUBXBaY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 20:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbUBXBaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 20:30:21 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.116]:51126 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S262172AbUBXB3Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 20:29:25 -0500
Date: Mon, 23 Feb 2004 17:29:20 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] warning in 2.4.19/fs/ext2/dir.c:ext2_empty_dir where
 a non-empty dir may be wrongly deleted
In-Reply-To: <20040224010248.GH31035@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.GSO.4.44.0402231728590.16945-100000@epic8.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks a lot for the quick confirmation!

On Tue, 24 Feb 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Mon, Feb 23, 2004 at 04:47:36PM -0800, Junfeng Yang wrote:
> >
> > The bug reported in this messaage appears to cause a non-empty directory
> > to be wrongly deleted by sys_rmdir.
>
> [ENOMEM returned by ext2_get_page() gets ignored, leading to breakage, 2.4
> and 2.6 alike]
>
> That's serious and yes, there are other cases like that.  Fun...
> OK, hopefully I'll have patches by tonight.
>

