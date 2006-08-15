Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965295AbWHOIV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965295AbWHOIV2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 04:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965294AbWHOIV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 04:21:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15854 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965286AbWHOIV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 04:21:27 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060815013114.GS29920@ftp.linux.org.uk> 
References: <20060815013114.GS29920@ftp.linux.org.uk>  <20060814211504.27190.10491.stgit@warthog.cambridge.redhat.com> <20060814211509.27190.51352.stgit@warthog.cambridge.redhat.com> 
To: Al Viro <viro@ftp.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RHEL5 PATCH 2/4] VFS: Make inode numbers 64-bits 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 15 Aug 2006 09:21:11 +0100
Message-ID: <7303.1155630071@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> wrote:

> NAK.  There's no need to touch i_ino and a lot of reasons for not doing
> that.  ->getattr() can fill 64bit field just fine without that and there's
> zero need to touch every fs out there *and* add cycles on icache lookups.
> WTF for?

That doesn't fix getdents64() though...

David
