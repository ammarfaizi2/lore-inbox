Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262626AbTCIVFu>; Sun, 9 Mar 2003 16:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262627AbTCIVFu>; Sun, 9 Mar 2003 16:05:50 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:52490 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S262626AbTCIVFO>; Sun, 9 Mar 2003 16:05:14 -0500
Date: Sun, 09 Mar 2003 14:15:47 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: mzyngier@freesurf.fr
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EISA aic7770 broken
Message-ID: <301080000.1047244547@aslan.scsiguy.com>
In-Reply-To: <wrp1y1gcv96.fsf@hina.wild-wind.fr.eu.org>
References: <wrp65qscwxx.fsf@hina.wild-wind.fr.eu.org>	<229560000.1047229710@aslan.scsiguy.com>
 <wrp1y1gcv96.fsf@hina.wild-wind.fr.eu.org>
X-Mailer: Mulberry/3.0.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Justin> Take a look in kernel/resource.c.  request_region returns
> Justin> *non-zero* if the region is already in use.  The driver
> Justin> doesn't want to try and probe a region that is in use by
> Justin> another device. Your patch is incorrect.
> 
> request_region returns a pointer to the newly allocated resource when
> it succeds, and NULL when it failed. It's the opposite logic
> check_region uses.

Sorry.  I missread the comment in kernel/resource.c.

> 
>>> But the driver crashes badly while probing the card, somewhere in
>>> ahc_runq_tasklet.
>>> 
>>> Any idea ?
> 
> Justin> Not without more information.
> 
> Ok, what can I do ?

Define crashes badly.  Driver messages or kernel panic strings typically
help.

--
Justin

