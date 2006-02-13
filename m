Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWBMMbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWBMMbh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 07:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWBMMbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 07:31:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10221 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932106AbWBMMbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 07:31:37 -0500
Date: Mon, 13 Feb 2006 04:30:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: mingo@elte.hu, tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] hrtimer: remove useless const
Message-Id: <20060213043038.25a49dd0.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0602131315150.30994@scrub.home>
References: <Pine.LNX.4.61.0602130209340.23804@scrub.home>
	<1139830116.2480.464.camel@localhost.localdomain>
	<Pine.LNX.4.61.0602131235180.30994@scrub.home>
	<20060213114612.GA30500@elte.hu>
	<20060213035354.65b04c15.akpm@osdl.org>
	<Pine.LNX.4.61.0602131315150.30994@scrub.home>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> wrote:
>
> Hi,
> 
> On Mon, 13 Feb 2006, Andrew Morton wrote:
> 
> > Ingo Molnar <mingo@elte.hu> wrote:
> > >
> > > your patch makes code larger on gcc3.
> > 
> > By 120 bytes here.  I dropped the patch.
> 
> Is this really worth it? This _is_ a compiler problem, are we going to add 
> now const everywhere to work around a (small) compiler problem, which is 
> already fixed in newer versions?
> 

Can't say I care a lot, but there doesn't seem much point in giving away
the consts now we have them, if it just produces worse code.

const arguments to functions are pretty useful for code readability and
maintainability too, if you use them consistently.

