Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbTKKWu4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 17:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbTKKWu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 17:50:56 -0500
Received: from ns.suse.de ([195.135.220.2]:64975 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263771AbTKKWuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 17:50:54 -0500
Date: Tue, 11 Nov 2003 23:50:52 +0100
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: mbligh@aracnet.com, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] zero out i_blocks in get_pipe_inode
Message-Id: <20031111235052.5e3dbfa4.ak@suse.de>
In-Reply-To: <20031111144842.137e396e.akpm@osdl.org>
References: <44940000.1068591898@flay>
	<20031111144842.137e396e.akpm@osdl.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Nov 2003 14:48:42 -0800
Andrew Morton <akpm@osdl.org> wrote:

> "Martin J. Bligh" <mbligh@aracnet.com> wrote:
> >
> >  +	inode->i_blocks = 0;
> 
> alloc_inode() already did that.

It didn't in 2.4 I think. But it may be worth auditing if all fields are covered.

-Andi
