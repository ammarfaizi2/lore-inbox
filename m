Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261329AbSJUKiP>; Mon, 21 Oct 2002 06:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261331AbSJUKiP>; Mon, 21 Oct 2002 06:38:15 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:33203 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261329AbSJUKiO>; Mon, 21 Oct 2002 06:38:14 -0400
Subject: Re: 2.5.41 still not testable by end users
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DAF8198.A66E0C82@digeo.com>
References: <3DAE2691.76F83D1B@digeo.com>
	<Pine.LNX.4.44.0210171717550.18123-100000@dad.molina>
	<3DAF3C36.2065CFD1@digeo.com> <m3smz4o415.fsf@averell.firstfloor.org> 
	<3DAF8198.A66E0C82@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 11:59:15 +0100
Message-Id: <1035197955.27318.32.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-18 at 04:35, Andrew Morton wrote:
> But it's a bit academic.  ia32's request_irq() calls proc_mkdir() and
> create_proc_entry().  So there's no point in feeding gfp_flags down
> into request_irq or whatever.  We need to fix IDE still.

I don't plan to fix the IDE layer, or the sound drivers, or the hundred
odd other drivers where this is close to impossible to fix. What is
broken is how we do IRQ setup still being like 0.12 not split.


