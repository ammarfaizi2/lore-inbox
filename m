Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161104AbWBNQPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161104AbWBNQPR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 11:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161110AbWBNQPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 11:15:16 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:3503 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161104AbWBNQPP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 11:15:15 -0500
Date: Tue, 14 Feb 2006 08:15:35 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@kernel.org
Subject: Re: [trivial PATCH] "drivers/usb/media/stv680.h": fix jiffies timeout
Message-ID: <20060214161535.GD5689@us.ibm.com>
References: <20060214163312.22960006@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214163312.22960006@localhost>
X-Operating-System: Linux 2.6.16-rc2 (x86_64)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.2006 [16:33:12 +0100], Paolo Ornati wrote:
> From: Paolo Ornati <ornati@fastwebnet.it>
> 
> stv680.c driver calls "usb_control_msg" passing PENCAM_TIMEOUT as
> jiffies timout. However PENCAM_TIMEOUT is defined to the fixed value of
> 1000, this leads to different timeouts with different HZ settings.
> 
> Since stv680.c is there since 2.4.18 I don't know if 1000 means 10s or
> 1s... I've picked the bigger.

NACK. PENCAM_TIMEOUT is a *milliseconds* timeout value.

>From the comment for usb_control_msg:

 *      @timeout: time in msecs to wait for the message to complete before
 *              timing out (if 0 the wait is forever)

Milliseconds do not depend on HZ in anyway.

Thanks,
Nish
