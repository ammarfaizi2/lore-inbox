Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbUBXBCz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 20:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbUBXBCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 20:02:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17856 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262121AbUBXBCv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 20:02:51 -0500
Date: Tue, 24 Feb 2004 01:02:48 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Junfeng Yang <yjf@stanford.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mc@cs.Stanford.EDU, Madanlal S Musuvathi <madan@stanford.edu>,
       "David L. Dill" <dill@cs.Stanford.EDU>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [CHECKER] warning in 2.4.19/fs/ext2/dir.c:ext2_empty_dir where a non-empty dir may be wrongly deleted
Message-ID: <20040224010248.GH31035@parcelfarce.linux.theplanet.co.uk>
References: <Pine.GSO.4.44.0402231645240.16698-100000@epic8.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0402231645240.16698-100000@epic8.Stanford.EDU>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 04:47:36PM -0800, Junfeng Yang wrote:
> 
> The bug reported in this messaage appears to cause a non-empty directory
> to be wrongly deleted by sys_rmdir.

[ENOMEM returned by ext2_get_page() gets ignored, leading to breakage, 2.4
and 2.6 alike]

That's serious and yes, there are other cases like that.  Fun...
OK, hopefully I'll have patches by tonight.
