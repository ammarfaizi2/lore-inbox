Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264315AbUACW4B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 17:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264318AbUACW4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 17:56:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:52155 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264315AbUACWz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 17:55:59 -0500
Date: Sat, 3 Jan 2004 14:55:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: John Lash <jlash@speakeasy.net>
Cc: alex.buell@munted.org.uk, linux-kernel@vger.kernel.org
Subject: Re: inode_cache / dentry_cache not being reclaimed aggressively
 enough  on low-memory PCs
Message-Id: <20040103145557.369a12c4.akpm@osdl.org>
In-Reply-To: <20040103103023.77bf91b5.jlash@speakeasy.net>
References: <Pine.LNX.4.58.0401031128100.2605@slut.local.munted.org.uk>
	<20040103103023.77bf91b5.jlash@speakeasy.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Lash <jlash@speakeasy.net> wrote:
>
> As it stands, it will maintain as many unused entries as there are used entries.
>  If this low memory system las a large, stable, number of inuse dentry objects,
>  the unused entries will match it thereby holding double the memory and possibly
>  causing the problem you see.

Yup.   There is a fix in 2.6.1-rc1 for this.
