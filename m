Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbTJMDAX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 23:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbTJMDAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 23:00:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:3051 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261347AbTJMDAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 23:00:22 -0400
Date: Sun, 12 Oct 2003 20:03:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Domen Puncer <domen@coderock.org>
Cc: zwane@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 3c59x on 2.6.0-test3->test6 slow
Message-Id: <20031012200330.1d5f1d8b.akpm@osdl.org>
In-Reply-To: <200310130428.21170.domen@coderock.org>
References: <200310061529.56959.domen@coderock.org>
	<200310130222.03175.domen@coderock.org>
	<20031012173702.57eea934.akpm@osdl.org>
	<200310130428.21170.domen@coderock.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Domen Puncer <domen@coderock.org> wrote:
>
> On Monday 13 of October 2003 02:37, Andrew Morton wrote:
> > Domen Puncer <domen@coderock.org> wrote:
> > > Tried a bunch of 2.5.x kernels... no better.
> > >  Then i tried 2.4.22... and my nic still doesn't work fast.
> >
> > There's some stuff in Documentation/networking/vortex.txt telling you how
> > to locate and run vortex-diag and mii-diag.
> 
> Should have read this before, sorry.
> 
> options=8 (autonegotiate) solves my problem. (driver could default to that?)
> Sorry for wasting your time.

The eeprom has a field which defines the default, and the driver honours
that.  I have a suspicion that the 3com windows just ignores the field.

You can reset the eeprom default with 3com's DOS-based setup tool.

