Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTHTPlX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 11:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbTHTPlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 11:41:19 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:25753 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262013AbTHTPlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 11:41:16 -0400
Subject: Re: IDE wierdness
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Larry McVoy <lm@bitmover.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030820150903.GA7246@work.bitmover.com>
References: <20030820150903.GA7246@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061394048.550.18.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 20 Aug 2003 16:40:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-08-20 at 16:09, Larry McVoy wrote:
> 
> It's clear to me that I don't want to use this drive but I'm wondering if
> there is any interest in debugging the lock up.  I've only done it on
> 2.4.18 as shipped by redhat but I could try 2.6 or whatever you like.
> 
> If the concensus is that it is OK that bad hardware locks you up then I'll
> toss the drive and move on.

Some PIO transfers are regulated by the drive and the drive can lock the
bus forever. Newer chipsets like the SI680/3112 support watchdog
deadlock breakers for this but we don't really support them right now.

Getting different data off a failing drive is unusual because the blocks
are ECC'd extensively (well more than ECC'd) and have checks, could be
the RAM/CPU going I guess.


