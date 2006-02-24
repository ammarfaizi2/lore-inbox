Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbWBXVgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbWBXVgK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 16:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbWBXVgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 16:36:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:4051 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932525AbWBXVgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 16:36:09 -0500
Date: Fri, 24 Feb 2006 21:35:54 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, David Teigland <teigland@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GFS2 Filesystem [0/16]
Message-ID: <20060224213553.GA8817@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steven Whitehouse <swhiteho@redhat.com>,
	Andrew Morton <akpm@osdl.org>, David Teigland <teigland@redhat.com>,
	linux-kernel@vger.kernel.org
References: <1140792511.6400.707.camel@quoit.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140792511.6400.707.camel@quoit.chygwyn.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  b) The .gfs2_admin directory exposes the internal files that GFS uses
>     to store various bits of file system related information. This means
>     that we've been able to remove virtually all the ioctl() calls from
>     GFS2. There is one ioctl() call left which relates to
>     getting/setting GFS2 specific flags on files. The various GFS2 tools
>     will be updated in due course to use this new interface.

Without even looking at the code a strong NACK here.  This is polluting
the namespace which is not acceptable.  Please implement a second
filesystem type gfsmeta to do this kind of admin work.  Search for ext2meta
which did something similar.  Or use a completely different approach,
I'd need to look at the actual functionality provided to give a better
advice, but currently I'm lacking the time for that.

