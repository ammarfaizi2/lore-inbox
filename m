Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbTJHSez (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 14:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbTJHSez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 14:34:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:48096 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261719AbTJHSex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 14:34:53 -0400
Date: Wed, 8 Oct 2003 11:34:06 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: vatsa@in.ibm.com
Cc: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       lkcd-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: [lkcd-devel] Re: [PATCH] Poll-based IDE driver
Message-Id: <20031008113406.2f2591c9.shemminger@osdl.org>
In-Reply-To: <20031008174458.A32517@in.ibm.com>
References: <20030917144120.A11425@in.ibm.com>
	<1063806900.12279.47.camel@dhcp23.swansea.linux.org.uk>
	<20031008151357.A31976@in.ibm.com>
	<20031008115051.GD705@redhat.com>
	<20031008174458.A32517@in.ibm.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.5claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Oct 2003 17:44:58 +0530
Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:

> On Wed, Oct 08, 2003 at 12:50:51PM +0100, Dave Jones wrote:
> > 
> > Why not just use udelay() ?  The above code cannot possibly do
> > the right thing on all processors.
> 
> Since my code is supposed to run when system is crashing, I would like 
> to avoid calling any function in the kernel as far as possible, since 
> the kernel and its data structures may be in a inconsistent state 
> and/or corrupted.

If your kernel context is alive enough to take the dump, then it should
be able to call things like udelay() that don't modify any data.  If it
can't your hosed already...
