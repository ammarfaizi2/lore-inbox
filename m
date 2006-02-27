Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWB0I6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWB0I6E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 03:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbWB0I6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 03:58:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26085 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751161AbWB0I6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 03:58:03 -0500
Subject: Re: GFS2 Filesystem [0/16]
From: Steven Whitehouse <swhiteho@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, David Teigland <teigland@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060224213553.GA8817@infradead.org>
References: <1140792511.6400.707.camel@quoit.chygwyn.com>
	 <20060224213553.GA8817@infradead.org>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 27 Feb 2006 09:03:04 +0000
Message-Id: <1141030984.6400.792.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-02-24 at 21:35 +0000, Christoph Hellwig wrote:
> >  b) The .gfs2_admin directory exposes the internal files that GFS uses
> >     to store various bits of file system related information. This means
> >     that we've been able to remove virtually all the ioctl() calls from
> >     GFS2. There is one ioctl() call left which relates to
> >     getting/setting GFS2 specific flags on files. The various GFS2 tools
> >     will be updated in due course to use this new interface.
> 
> Without even looking at the code a strong NACK here.  This is polluting
> the namespace which is not acceptable.  Please implement a second
> filesystem type gfsmeta to do this kind of admin work.  Search for ext2meta
> which did something similar.  Or use a completely different approach,
> I'd need to look at the actual functionality provided to give a better
> advice, but currently I'm lacking the time for that.
> 
Of all the comments we've received so far, this one raises the most
issues for us. Let me think about this one for a day or two and I'll get
back to you. Ideally we'd like to do it the way you propose, but I need
to check that it doesn't raise any other problems before I commit to
actually doing it,

Steve.


