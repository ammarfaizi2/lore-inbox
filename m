Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272010AbTG2TK0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 15:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272011AbTG2TK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 15:10:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:31398 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272010AbTG2TKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 15:10:18 -0400
Date: Tue, 29 Jul 2003 11:58:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: albert@users.sourceforge.net, zwane@arm.linux.org.uk,
       linux-yoann@ifrance.com, linux-kernel@vger.kernel.org, akpm@digeo.com,
       vortex@scyld.com, jgarzik@pobox.com
Subject: Re: another must-fix: major PS/2 mouse problem
Message-Id: <20030729115825.5347b487.akpm@osdl.org>
In-Reply-To: <1059482410.3862.120.camel@cube>
References: <1054431962.22103.744.camel@cube>
	<3EDCF47A.1060605@ifrance.com>
	<1054681254.22103.3750.camel@cube>
	<3EDD8850.9060808@ifrance.com>
	<1058921044.943.12.camel@cube>
	<20030724103047.31e91a96.akpm@osdl.org>
	<1059097601.1220.75.camel@cube>
	<20030725201914.644b020c.akpm@osdl.org>
	<Pine.LNX.4.53.0307261112590.12159@montezuma.mastecende.com>
	<1059447325.3862.86.camel@cube>
	<20030728201459.78c8c7c6.akpm@osdl.org>
	<1059482410.3862.120.camel@cube>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan <albert@users.sourceforge.net> wrote:
>
> > So this looks OK, yes?
> 
> I suppose boomerang_interrupt itself is OK.
> Spending 104 ms in IRQ 0, 31 ms in IRQ 11, and
> 44 ms in IRQ 14 is not at all OK. I was hoping
> to get under 200 microseconds for everything.

I misread that.

Last time I checked (which was about 18 months ago) the maximum
interrupts-off time on a 500MHz desktop-class machine was 80 microseconds.

Something is broken there.  Do you have another machine to sanity check
against?
