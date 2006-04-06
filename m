Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWDFKFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWDFKFs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 06:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWDFKFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 06:05:47 -0400
Received: from www.osadl.org ([213.239.205.134]:47028 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751142AbWDFKFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 06:05:47 -0400
Subject: Re: [PATCH 1/5] generic clocksource updates
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: johnstul@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0604032155070.4707@scrub.home>
References: <Pine.LNX.4.64.0604032155070.4707@scrub.home>
Content-Type: text/plain
Date: Thu, 06 Apr 2006 12:06:11 +0200
Message-Id: <1144317972.5344.681.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-03 at 21:55 +0200, Roman Zippel wrote:
>  struct clocksource {
>  	char *name;
> @@ -58,11 +57,11 @@ struct clocksource {
>  	u32 mult;
>  	u32 shift;
>  	int (*update_callback)(void);
> -	int is_continuous;

This field was introduced to have a clear property description. The
rating field might be used for this, but from a given rating on a
particular CPU architecture it might be hard to deduce whether this
clock source is good enough so we can switch to high resolution timer
mode.

is_continous is maybe not the best choice, but a flag field to retrieve
certain properties would be a good thing to have.

	tglx




