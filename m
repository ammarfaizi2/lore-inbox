Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVFKTBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVFKTBD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 15:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVFKTBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 15:01:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61134 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261782AbVFKTBA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 15:01:00 -0400
Date: Sat, 11 Jun 2005 12:00:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stephen Lord <lord@xfs.org>
Cc: pozsy@uhulinux.hu, linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: Race condition in module load causing undefined symbols
Message-Id: <20050611120040.084942ed.akpm@osdl.org>
In-Reply-To: <42AB25E7.5000405@xfs.org>
References: <42A99D9D.7080900@xfs.org>
	<20050610112515.691dcb6e.akpm@osdl.org>
	<20050611082642.GB17639@ojjektum.uhulinux.hu>
	<42AAE5C8.9060609@xfs.org>
	<20050611150525.GI17639@ojjektum.uhulinux.hu>
	<42AB25E7.5000405@xfs.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Lord <lord@xfs.org> wrote:
>
> Pozsár Balázs wrote:
>  > On Sat, Jun 11, 2005 at 08:23:20AM -0500, Steve Lord wrote:
>  > 
>  >>I think this is not actually module loading itself, but a problem
>  >>between the fork/exec/wait code in nash and the kernel.
>  > 
>  > 
>  > I do not use nash, only bash, so this is not a nash-specific issue.
>  > 
>  > 
> 
>  I disabled hyperthreading and things started working, so are there any
>  HT related scheduling bugs right now?

There haven't been any scheduler changes for some time.  There have been a
few low-level SMT changes I think.

Are you able to identify which kernel version broke it?
