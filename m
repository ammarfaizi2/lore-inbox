Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVGTQ02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVGTQ02 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 12:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVGTQ01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 12:26:27 -0400
Received: from b.mail.sonic.net ([64.142.19.5]:7600 "EHLO b.mail.sonic.net")
	by vger.kernel.org with ESMTP id S261224AbVGTQ00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 12:26:26 -0400
Date: Wed, 20 Jul 2005 09:26:20 -0700
From: David Hinds <dhinds@sonic.net>
To: somshekar.c.kadam@in.abb.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sandisk Compact Flash
Message-ID: <20050720162620.GA4555@sonic.net>
References: <OF56551899.13BEFC21-ON65257044.00280854-65257044.00282876@abbasiapacific.com.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF56551899.13BEFC21-ON65257044.00280854-65257044.00282876@abbasiapacific.com.sg>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2005 at 12:49:00PM +0530, somshekar.c.kadam@in.abb.com wrote:
> 
> Hi David ,
> 
> On my controller CF INPACK pin is connected to 3.3v.  so Comapct
> flash with DMA capabilty will not be supported , i understood this .
> but i did not undesrtand why only PIO mode 1 is supported is it ,
> why not PIO mode 4 , is it a limitation of pcmcia driver , correct
> me if i am wrong

The 16-bit PCMCIA bus is maxed out at about 1 MB/sec; that's all the
bandwidth there is.  What your card supports is irrelevant.

I'm not sure whether the PCMCIA mode actually corresponds to any of
the official PIO modes 0, 1, etc.  It is just "slow".

-- Dave
