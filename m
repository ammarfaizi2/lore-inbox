Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262542AbTCIQ55>; Sun, 9 Mar 2003 11:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262543AbTCIQ55>; Sun, 9 Mar 2003 11:57:57 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:16649 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S262542AbTCIQ54>; Sun, 9 Mar 2003 11:57:56 -0500
Date: Sun, 09 Mar 2003 10:08:30 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: mzyngier@freesurf.fr
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EISA aic7770 broken
Message-ID: <229560000.1047229710@aslan.scsiguy.com>
In-Reply-To: <wrp65qscwxx.fsf@hina.wild-wind.fr.eu.org>
References: <wrp65qscwxx.fsf@hina.wild-wind.fr.eu.org>
X-Mailer: Mulberry/3.0.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Justin,
> 
> I'm having troubles getting an Adaptec AHA-2740 (EISA) running on
> 2.5.64.
> 
> First thing is the initial request_region succeeds, but the driver
> thinks it failed... The enclosed patch fixes it.

Take a look in kernel/resource.c.  request_region returns *non-zero*
if the region is already in use.  The driver doesn't want to try and
probe a region that is in use by another device. Your patch is incorrect.

> But the driver crashes badly while probing the card, somewhere in
> ahc_runq_tasklet.
> 
> Any idea ?

Not without more information.

--
Justin

