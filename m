Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423521AbWJaP7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423521AbWJaP7E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 10:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423522AbWJaP7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 10:59:04 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:27755 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1423521AbWJaP7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 10:59:01 -0500
Date: Tue, 31 Oct 2006 07:54:27 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       Evgeniy Dushistov <dushistov@mail.ru>
Subject: Re: [PATCH] fix UFS superblock alignment issues
Message-Id: <20061031075427.77ce2653.randy.dunlap@oracle.com>
In-Reply-To: <45476A36.2020405@redhat.com>
References: <4546C701.9020707@redhat.com>
	<45476A36.2020405@redhat.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2006 09:22:30 -0600 Eric Sandeen wrote:

> Eric Sandeen wrote:
> > ufs2 fails to mount on x86_64, claiming bad magic.  This is because 
> > ufs_super_block_third's fs_un1 member is padded out by 4 bytes for
> > 8-byte alignment, pushing down the rest of the struct.
> > 
> > Forcing this to be packed solves it.  I took a quick look over
> > other on-disk structures and didn't immediately find other problems.
> > I was able to mount & ls a populated ufs2 filesystem w/ this change.
> 
> I should also mention that this seems to be a regression from
> 2.6.17->2.6.18, so perhaps it's a candidate for 2.6.18.x updates.

Please send it to stable@kernel.org .

---
~Randy
