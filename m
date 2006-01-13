Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWAMHtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWAMHtM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 02:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932649AbWAMHtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 02:49:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37308 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932381AbWAMHtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 02:49:10 -0500
Date: Thu, 12 Jan 2006 23:48:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [PATCH] reiserfs: remove kmalloc wrapper
Message-Id: <20060112234846.3a20f5a1.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0601130942540.20349@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0601130930130.17696@sbz-30.cs.Helsinki.FI>
	<20060112233920.4b3b0a26.akpm@osdl.org>
	<Pine.LNX.4.58.0601130942540.20349@sbz-30.cs.Helsinki.FI>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
>
> Hi Andrew,
> 
> Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
> > > This patch removes kmalloc() wrapper from fs/reiserfs/. Please note that 
> > >  a reiserfs /proc entry format is changed because kmalloc statistics is 
> > >  removed.
> 
> On Thu, 12 Jan 2006, Andrew Morton wrote:
> > I wonder if it'd be safer to just spit out a zero where that number used to
> > be?
> 
> Yup but then again it has no business being there in the first place. 
> Please let me know if you like printing out zero instead and I'll whack up 
> a patch.
> 

That's up to the reiserfs guys (please).

It would have helped had you described the exact /proc pathname so people
could remember whether there's anything which actually uses it.
