Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316757AbSGLSel>; Fri, 12 Jul 2002 14:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316768AbSGLSek>; Fri, 12 Jul 2002 14:34:40 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:47886 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316757AbSGLSej>; Fri, 12 Jul 2002 14:34:39 -0400
Date: Fri, 12 Jul 2002 20:37:11 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Thunder from the hill <thunder@ngforever.de>
cc: Roman Zippel <zippel@linux-m68k.org>,
       Dawson Engler <engler@csl.stanford.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <mc@cs.stanford.edu>
Subject: Re: [CHECKER] 56 potential lock/unlock bugs in 2.5.8
In-Reply-To: <Pine.LNX.4.44.0207121151180.3421-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44.0207122032260.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 12 Jul 2002, Thunder from the hill wrote:

> You mean
>
> static inline int affs_rmdir(struct inode *dir, struct dentry *dentry)
> {
> 	int res;
> 	lock_kernel();
> 	res = affs_remove_header(dentry);
> 	unlock_kernel();
> 	return res;
> }

lock_kernel isn't required here. Yesterday I went through affs and removed
the BKL completely.

bye, Roman

