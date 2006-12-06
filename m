Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760329AbWLFI7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760329AbWLFI7q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 03:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760341AbWLFI7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 03:59:46 -0500
Received: from mga09.intel.com ([134.134.136.24]:25511 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760329AbWLFI7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 03:59:45 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,503,1157353200"; 
   d="scan'208"; a="23751604:sNHT19790874"
Date: Wed, 6 Dec 2006 00:58:27 -0800
From: Valerie Henson <val_henson@linux.intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mark.fasheh@oracle.com, steve@chygwyn.com, linux-kernel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk
Subject: Re: Relative atime (was Re: What's in ocfs2.git)
Message-ID: <20061206085826.GF8482@goober>
References: <20061203203149.GC19617@ca-server1.us.oracle.com> <1165229693.3752.629.camel@quoit.chygwyn.com> <20061205001007.GF19617@ca-server1.us.oracle.com> <20061205003619.GC8482@goober> <20061205205802.92b91ce1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061205205802.92b91ce1.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 08:58:02PM -0800, Andrew Morton wrote:
> > On Mon, 4 Dec 2006 16:36:20 -0800 Valerie Henson <val_henson@linux.intel.com> wrote:
> > Add "relatime" (relative atime) support.  Relative atime only updates
> > the atime if the previous atime is older than the mtime or ctime.
> > Like noatime, but useful for applications like mutt that need to know
> > when a file has been read since it was last modified.
> 
> That seems like a good idea.
> 
> I found touch_atime() to be rather putrid, so I hacked it around a bit.  The
> end result:

I like that rather better - add my:

Signed-off-by: Valerie Henson <val_henson@linux.intel.com>

> That's the easy part.   How are we going to get mount(8) patched?

Well, the nodiratime documentation got in. (I was going to add that as
part of this apatch, but lo and behold.)

-VAL
