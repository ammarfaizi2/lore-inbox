Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965299AbWHOIdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965299AbWHOIdL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 04:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965298AbWHOIdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 04:33:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39813 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965237AbWHOIdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 04:33:09 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060815013114.GS29920@ftp.linux.org.uk> 
References: <20060815013114.GS29920@ftp.linux.org.uk>  <20060814211504.27190.10491.stgit@warthog.cambridge.redhat.com> <20060814211509.27190.51352.stgit@warthog.cambridge.redhat.com> 
To: Al Viro <viro@ftp.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RHEL5 PATCH 2/4] VFS: Make inode numbers 64-bits 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 15 Aug 2006 09:32:57 +0100
Message-ID: <7619.1155630777@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> wrote:

> NAK.  There's no need to touch i_ino and a lot of reasons for not doing
> that.

Like all those printks that write ambiguous messages because they can't report
the full inode number?  I'm not so worried about those because they're for the
most part debugging messages, but still, they *can* report invalid information
because i_ino is not big enough in error and warning messages.

David
