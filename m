Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWAEXCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWAEXCG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWAEXCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:02:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3289 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932151AbWAEXCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:02:04 -0500
Date: Thu, 5 Jan 2006 15:01:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kumar Gala <galak@gate.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm1
Message-Id: <20060105150142.54618ca9.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0601051135100.1019-100000@gate.crashing.org>
References: <20060105062249.4bc94697.akpm@osdl.org>
	<Pine.LNX.4.44.0601051135100.1019-100000@gate.crashing.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala <galak@gate.crashing.org> wrote:
>
> Andrew,
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm1/
> > 
> > 
> > - ppc32 builds are broken
> 
> Do you have build logs somewhere for this.  I've got one patch that 
> address a build failure for ppc32, however I need to get with BenH to 
> figure out he considers pmac CONFIG_BROKEN for ARCH=ppc and that everyone 
> should use ARCH=powerpc for it.

git-powerpc.patch removes last_jiffy_stamp(), but arch/ppc/kernel/time.c
still uses it.  Ben and Paul have been informed.
