Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965312AbWHOJCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965312AbWHOJCt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 05:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965311AbWHOJCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 05:02:48 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:8354 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965310AbWHOJCr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 05:02:47 -0400
Date: Tue, 15 Aug 2006 10:02:43 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RHEL5 PATCH 2/4] VFS: Make inode numbers 64-bits
Message-ID: <20060815090243.GT29920@ftp.linux.org.uk>
References: <20060815013114.GS29920@ftp.linux.org.uk> <20060814211504.27190.10491.stgit@warthog.cambridge.redhat.com> <20060814211509.27190.51352.stgit@warthog.cambridge.redhat.com> <7619.1155630777@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7619.1155630777@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 09:32:57AM +0100, David Howells wrote:
> Al Viro <viro@ftp.linux.org.uk> wrote:
> 
> > NAK.  There's no need to touch i_ino and a lot of reasons for not doing
> > that.
> 
> Like all those printks that write ambiguous messages because they can't report
> the full inode number?  I'm not so worried about those because they're for the
> most part debugging messages, but still, they *can* report invalid information
> because i_ino is not big enough in error and warning messages.

In fs-independent code?  How many of those do we actually have?
