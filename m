Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269457AbUI3ThM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269457AbUI3ThM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 15:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269452AbUI3ThM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 15:37:12 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:17808 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269442AbUI3ThK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 15:37:10 -0400
Subject: Re: Serial driver hangs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Roland =?ISO-8859-1?Q?Ca=DFebohm?= 
	<roland.cassebohm@VisionSystems.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <1096571398.1938.112.camel@deimos.microgate.com>
References: <200409281734.38781.roland.cassebohm@visionsystems.de>
	 <200409291607.07493.roland.cassebohm@visionsystems.de>
	 <1096467951.1964.22.camel@deimos.microgate.com>
	 <200409301816.44649.roland.cassebohm@visionsystems.de>
	 <1096571398.1938.112.camel@deimos.microgate.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096569273.19487.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 30 Sep 2004 19:34:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-30 at 20:09, Paul Fulghum wrote:
> The gaping hole in the flip buffer scheme is
> flush_to_ldisc() can be called from hard IRQ
> context while ldisc->receive_buf() is running.

This is strictly forbidden and always has been. I've no
plan to touch that restriction merely to re-educate 
any offender

