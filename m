Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWF2TqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWF2TqB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWF2TqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:46:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56705 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932340AbWF2TqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:46:00 -0400
Date: Thu, 29 Jun 2006 12:44:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] kernel/sys.c: remove unused exports
Message-Id: <20060629124400.ee22dfbf.akpm@osdl.org>
In-Reply-To: <20060629123608.a2a5c5c0.akpm@osdl.org>
References: <20060629191940.GL19712@stusta.de>
	<20060629123608.a2a5c5c0.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 12:36:08 -0700
Andrew Morton <akpm@osdl.org> wrote:

> On Thu, 29 Jun 2006 21:19:40 +0200
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > This patch removes the following unused exports:
> > - EXPORT_SYMBOL:
> >   - in_egroup_p
> > - EXPORT_SYMBOL_GPL's:
> >   - kernel_restart
> >   - kernel_halt
> 
> Switch 'em to EXPORT_UNUSED_SYMBOL and I'll stop dropping your patches ;)
> 

If doing this, I'd suggest it be done thusly:

EXPORT_UNUSED_SYMBOL(in_egroup_p);	/* June 2006 */

to aid later decision-making.
