Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270142AbTGZPPi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 11:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272555AbTGZPO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 11:14:59 -0400
Received: from [66.212.224.118] ([66.212.224.118]:35086 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S270140AbTGZPMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 11:12:49 -0400
Date: Sat, 26 Jul 2003 11:16:25 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andrew Morton <akpm@osdl.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>, linux-yoann@ifrance.com,
       linux-kernel@vger.kernel.org, akpm@digeo.com, vortex@scyld.com,
       jgarzik@pobox.com
Subject: Re: another must-fix: major PS/2 mouse problem
In-Reply-To: <20030725201914.644b020c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0307261112590.12159@montezuma.mastecende.com>
References: <1054431962.22103.744.camel@cube> <3EDCF47A.1060605@ifrance.com>
 <1054681254.22103.3750.camel@cube> <3EDD8850.9060808@ifrance.com>
 <1058921044.943.12.camel@cube> <20030724103047.31e91a96.akpm@osdl.org>
 <1059097601.1220.75.camel@cube> <20030725201914.644b020c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jul 2003, Andrew Morton wrote:

> But did your instrumentation account for nested interrupts?  What happens
> if a slow i8042 interrupt happens in the middle of a 3c59x interrupt?

Just to verify that, he could remove the local_irq_enable for 
!SA_INTERRUPT.

	Zwane
-- 
function.linuxpower.ca
