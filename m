Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbUDAIid (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 03:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbUDAIid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 03:38:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:39872 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262689AbUDAIic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 03:38:32 -0500
Date: Thu, 1 Apr 2004 00:38:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Soeren Noehr Christensen <snc@cs.auc.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Getting a dentry from an inode.
Message-Id: <20040401003816.5a62b888.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.56.0404011016490.10829@homer.cs.auc.dk>
References: <Pine.LNX.4.56.0404011016490.10829@homer.cs.auc.dk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Soeren Noehr Christensen <snc@cs.auc.dk> wrote:
>
> I'm working on a securityproject (umbrella.sourceforge.net), we need to
>  access the dentry struct(s) associated with a particular inode, and all we
>  have access to is the inode struct. Does anyone know how to do get the
>  dentry structs from this?

Walk inode->i_dentry.  See d_find_alias() for similar code.
