Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbWFCILS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbWFCILS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 04:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWFCILS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 04:11:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25762 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030260AbWFCILQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 04:11:16 -0400
Date: Sat, 3 Jun 2006 01:11:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: kenneth.w.chen@intel.com, nickpiggin@yahoo.com.au, mason@suse.com,
       kernel@kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] fix smt nice lock contention and optimization
Message-Id: <20060603011107.4c6de627.akpm@osdl.org>
In-Reply-To: <20060603074920.GB20229@elte.hu>
References: <000701c686e1$71f2f7f0$df34030a@amr.corp.intel.com>
	<20060603074920.GB20229@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jun 2006 09:49:20 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:
> 
> > Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>
> > ---
> > 
> >  sched.c |  168 ++++++++++++++++++----------------------------------------------
> >  1 files changed, 48 insertions(+), 120 deletions(-)
> 
> looks really good now to me.
> 
>  Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> lets try it in -mm?
> 

Yup.  I redid Ken's patch against mainline and them mangled
lock-validator-special-locking-schedc.patch to suit.

