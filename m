Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262429AbVGLVIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbVGLVIQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 17:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbVGLVFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 17:05:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25028 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262426AbVGLVDr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 17:03:47 -0400
Date: Tue, 12 Jul 2005 14:02:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alasdair G Kergon <agk@redhat.com>
Cc: laurent.riffard@free.fr, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc2-mm2 : oops in dm_mod
Message-Id: <20050712140248.3cdcb9b8.akpm@osdl.org>
In-Reply-To: <20050712204751.GB12341@agk.surrey.redhat.com>
References: <20050712021724.13b2297a.akpm@osdl.org>
	<42D41177.9020300@free.fr>
	<20050712204751.GB12341@agk.surrey.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alasdair G Kergon <agk@redhat.com> wrote:
>
> I'm downloading -mm2 as I write this to check, but I can't
>  spot the part of the patch that updates dm-table.c to read:
> 
>  void dm_table_presuspend_targets(struct dm_table *t)
>  {
>          if (!t)
>                  return;
> 
>          return suspend_targets(t, 0);
>  }
>                                                                                  
>  void dm_table_postsuspend_targets(struct dm_table *t)
>  {
>          if (!t)
>                  return;
>                                                                                  
>          return suspend_targets(t, 1);
>  }

There's no patch in -mm which adds those tests of `t'.
