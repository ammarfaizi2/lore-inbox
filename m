Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbTDQO5c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 10:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbTDQO5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 10:57:32 -0400
Received: from havoc.daloft.com ([64.213.145.173]:21135 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261620AbTDQO5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 10:57:31 -0400
Date: Thu, 17 Apr 2003 11:09:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: John Bradford <john@grabjohn.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Patrick Mochel <mochel@osdl.org>,
       Grover Andrew <andrew.grover@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Subtle semantic issue with sleep callbacks in drivers
Message-ID: <20030417150926.GA25402@gtf.org>
References: <20030417144844.GC18749@gtf.org> <200304171509.h3HF9PS1000278@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304171509.h3HF9PS1000278@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 04:09:25PM +0100, John Bradford wrote:
> > The video BIOS on a card often contains information that is found
> > -nowhere- else.  Not in the chip docs.  Not in a device driver.
> > Such information can and does vary from board-to-board, such as RAM
> > timings, while the chip remains unchanged.
> 
> Incidently, what happens if we:
> 
> * Suspend
> * Swap VGA card with another one
> * Restore

When it breaks, you get to keep both pieces.

That's a "Don't Do That" issue for any hardware between suspend
and resume.

	Jeff



