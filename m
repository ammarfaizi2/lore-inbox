Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263320AbTJQHWK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 03:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbTJQHWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 03:22:10 -0400
Received: from asplinux.ru ([195.133.213.194]:48139 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S263320AbTJQHWI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 03:22:08 -0400
From: Kirill Korotaev <dev@sw.ru>
Reply-To: dev@sw.ru
Organization: SWsoft
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-test7-mm1
Date: Fri, 17 Oct 2003 11:23:14 +0400
User-Agent: KMail/1.5.1
References: <3F8EAEB5.5040102@austin.ibm.com> <20031016075815.266e5c4b.akpm@osdl.org>
In-Reply-To: <20031016075815.266e5c4b.akpm@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310171123.14936.dev@sw.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On reboot after heavy IO loads (tiobench) I keep getting the following 
> >  oops.
> 
> Yup.  The "invalidate_inodes-speedup-fixes" and "invalidate_inodes-speedup"
> patches were not so great and need to be reverted.

I've found that fs/hugetlbfs/inode.c miss list_del(&inode->i_sb_list) when delete/forget inode is
called. Probably this can break sb_list and might be the cause.

Kirill

