Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263027AbUENWbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263027AbUENWbv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 18:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbUENWbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 18:31:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:65434 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263027AbUENWbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 18:31:50 -0400
Date: Fri, 14 May 2004 15:34:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [4KSTACK][2.6.6] Stack overflow in radeonfb
Message-Id: <20040514153407.0879b930.akpm@osdl.org>
In-Reply-To: <1084571316.31315.35.camel@gaston>
References: <20040513145640.GA3430@dreamland.darkstar.lan>
	<1084488901.3021.116.camel@gaston>
	<20040514164154.GA3852@dreamland.darkstar.lan>
	<1084571316.31315.35.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> 
> > There are 2 arrays at the end of the struct:
> > 
> > struct radeon_regs {
> >         ....
> >         u32             palette[256];
> >         u32             palette2[256];
> > };
> > 
> > they take 2KB alone and AFAICS they are not used anywhere. Maybe they
> > can be removed?
> 
> They are the result of some work in progress on my side. I started
> adding the entire card state to the structure, but never finished.
> 
> I'll probably go back on that when I find time though.

Can we remove them for now?  People's machines are crashing...
