Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbUFCJB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUFCJB2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 05:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUFCJB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 05:01:28 -0400
Received: from sd291.sivit.org ([194.146.225.122]:38342 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261925AbUFCJBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 05:01:17 -0400
Date: Thu, 3 Jun 2004 11:00:45 +0200
From: Stelian Pop <stelian@popies.net>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Daniel Drake <dsd@gentoo.org>, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use msleep in meye driver
Message-ID: <20040603090044.GB3621@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Arjan van de Ven <arjanv@redhat.com>, Daniel Drake <dsd@gentoo.org>,
	video4linux-list@redhat.com, linux-kernel@vger.kernel.org
References: <40BDF8E6.6040601@gentoo.org> <20040603083848.GA3621@crusoe.alcove-fr> <1086252437.2709.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086252437.2709.0.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 10:47:18AM +0200, Arjan van de Ven wrote:

> 
> > >From what I see in kernel/timer.c, msleep() cannot be called in
> > interrupt context, so the in_interrupt() test must stay.
> 
> mdelay in irq context is *EVIL* though, and will get all the low latency
> and audio folks very upset...

Indeed :)

In fact, reading the code again shows that wait_ms() is never called
in interrupt context, so the in_interrupt() test was useless.

Daniel's patch is then correct, please apply it.

Or should I add a "Signed-off" line too and resend the patch ?

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
