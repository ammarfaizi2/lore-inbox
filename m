Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263968AbTEOLTK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 07:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263969AbTEOLTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 07:19:10 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:51860 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263968AbTEOLTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 07:19:09 -0400
Date: Thu, 15 May 2003 12:32:58 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: [PATCH] iphase fix.
Message-ID: <20030515113258.GA31078@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	netdev@oss.sgi.com
References: <200305150417.h4F4HTRA025809@hera.kernel.org> <3EC3359D.5050207@pobox.com> <3EC336FE.1030805@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC336FE.1030805@pobox.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 02:43:10AM -0400, Jeff Garzik wrote:
 > Jeff Garzik wrote:
 > >>         dev_kfree_skb(skb);
 > >>-    else
 > >>-        netif_wake_queue(dev);
 > >>+    netif_wake_queue(dev);
 > >>     LEAVE("iph5526_send_packet");
 > >
 > >This appears to revert a fix.
 > >You only want to wake the queue if you have room to queue another skb.
 > 
 > Actually, I'm wrong.
 > 
 > But it could still use some looking-at.  You don't want to stop_queue at 
 > the beginning of send_packet and wake_queue at the end.  Instead, the 
 > queue should be awakened in the Tx completion routine, and the 
 > stop_queue should be moved from the beginning to the end of the function.

Bring it up with whoever merged it into 2.4..

		Dave

