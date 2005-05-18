Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262281AbVERSVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbVERSVL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 14:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbVERSVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 14:21:10 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:61738 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262281AbVERSUl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 14:20:41 -0400
Date: Wed, 18 May 2005 20:22:17 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: Re: sparse error: unable to open 'stdarg.h'
Message-ID: <20050518182217.GA8130@mars.ravnborg.org>
References: <428A661C.1030100@ammasso.com> <428A729E.8040207@ammasso.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428A729E.8040207@ammasso.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 05:39:26PM -0500, Timur Tabi wrote:
> Timur Tabi wrote:
> 
> >make -C /lib/modules/2.6.8-24-smp/source 
> >SUBDIRS=/root/AMSO1100/software/host/linux/sys/devccil  C=1 V=2
> 
> When I replace V=2 with V=1 (don't know how that happened), I get this 
> output:
> 
> sparse  -D__i386__=1 
> -Wp,-MD,/root/AMSO1100/software/host/linux/sys/devccil/.devnet.o.d 
> -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude  -Wall 

Newer kbuild's do not use the -nostdinc -iwithprefix include trick.
Instead they use -nostdinc -isystem `gcc --print-file-name=include`

Wich is a more reliable way to find stdarg.h. Newer sparse understands
this too.

Please post make V=1 output with a newer kernel.

	Sam
