Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264463AbUADFbd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 00:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUADFbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 00:31:33 -0500
Received: from mail4.speakeasy.net ([216.254.0.204]:36034 "EHLO
	mail4.speakeasy.net") by vger.kernel.org with ESMTP id S264463AbUADFbc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 00:31:32 -0500
Date: Sat, 3 Jan 2004 23:31:17 -0600
From: John Lash <jlash@speakeasy.net>
To: Andrew Morton <akpm@osdl.org>
Cc: alex.buell@munted.org.uk, linux-kernel@vger.kernel.org
Subject: Re: inode_cache / dentry_cache not being reclaimed aggressively 
 enough  on low-memory PCs
Message-Id: <20040103233117.6476a799.jlash@speakeasy.net>
In-Reply-To: <20040103145557.369a12c4.akpm@osdl.org>
References: <Pine.LNX.4.58.0401031128100.2605@slut.local.munted.org.uk>
	<20040103103023.77bf91b5.jlash@speakeasy.net>
	<20040103145557.369a12c4.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.6claws71 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ahh, good. I'll take a look. Thanks Andrew.

--john


On Sat, 3 Jan 2004 14:55:57 -0800
Andrew Morton <akpm@osdl.org> wrote:

> John Lash <jlash@speakeasy.net> wrote:
> >
> > As it stands, it will maintain as many unused entries as there are used
> > entries.
> >  If this low memory system las a large, stable, number of inuse dentry
> >  objects, the unused entries will match it thereby holding double the memory
> >  and possibly causing the problem you see.
> 
> Yup.   There is a fix in 2.6.1-rc1 for this.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
