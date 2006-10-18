Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWJRIgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWJRIgO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 04:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWJRIgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 04:36:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12954 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932106AbWJRIgL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 04:36:11 -0400
Date: Wed, 18 Oct 2006 01:35:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, mhalcrow@us.ibm.com,
       penberg@cs.helsinki.fi, linux-fsdevel@vger.kernel.org
Subject: Re: fsstack: struct path
Message-Id: <20061018013551.3745e1d5.akpm@osdl.org>
In-Reply-To: <20061018013103.4ad6311a.akpm@osdl.org>
References: <20061018042323.GA8537@filer.fsl.cs.sunysb.edu>
	<20061018013103.4ad6311a.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006 01:31:03 -0700
Andrew Morton <akpm@osdl.org> wrote:

> > One, rather unfortunate, fact is that struct path is also defined in
> > include/linux/reiserfs_fs.h as something completely different - reiserfs
> > specific.
> > 
> > Any thoughts?
> > 
> 
> reiserfs is being bad.  s/path/reiserfs_path/g

There's also drivers/md/dm-mpath.h's struct path.  Renaming fs/namei.c's
`struct path' to `struct namei_path' would be prudent.

