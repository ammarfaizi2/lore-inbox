Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbWFBT5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWFBT5T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWFBT5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:57:18 -0400
Received: from pat.uio.no ([129.240.10.4]:16319 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751470AbWFBT5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:57:17 -0400
Subject: Re: d_entry delete ( d_delete ) in d_cache.c on linux 2.6.15 and
	beyond
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Flavio <ff@member.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <fa7d16350606021241v632d0a77l600ffea513cf37b9@mail.gmail.com>
References: <fa7d16350606021241v632d0a77l600ffea513cf37b9@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 02 Jun 2006 15:57:09 -0400
Message-Id: <1149278229.5621.44.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.833, required 12,
	autolearn=disabled, AWL 1.17, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-02 at 15:41 -0400, Flavio wrote:
> Hello,
> 
> I notice that on versions 2.6.15 and later, the function
> 
>      void d_delete(struct dentry * dentry)
> 
> Implements a mechanism for notifying the deletion of the d_entry.
> 
> The implementation assumes that the d_entry has a non-null d_inode pointer
> and that seems to be terribly wrong. In other words, how can a
> "negative d_entry"
> be deleted?

d_drop()?

> Implementation of rename may use dummy dentries (that have d_inode
> set to NULL) and that is a problem as well.

d_drop()!

Cheers,
  Trond

