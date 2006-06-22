Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWFVF57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWFVF57 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 01:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWFVF56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 01:57:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37854 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750817AbWFVF56 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 01:57:58 -0400
Date: Wed, 21 Jun 2006 22:57:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Olson <olson@unixfolk.com>
Cc: mingo@elte.hu, ccb@acm.org, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Subject: Re: [patch] increase spinlock-debug looping timeouts (write_lock
 and NMI)
Message-Id: <20060621225752.93cfffb0.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0606212243240.32136@osa.unixfolk.com>
References: <Pine.LNX.4.61.0606212243240.32136@osa.unixfolk.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 22:45:49 -0700 (PDT)
Dave Olson <olson@unixfolk.com> wrote:

> On Tue, 20 Jun 2006, Andrew Morton wrote:
> | > Intended to be more or less stock fc4 but with CONFIG_PCI_MSI=y and
> | > 2.6.17-based patch so the 8131 MSI quirk isn't enabled.
> | > 
> | > >From the config file:
> | > 	CONFIG_DEBUG_SPINLOCK=y
> | > 	CONFIG_DEBUG_SPINLOCK_SLEEP=y
> | 
> | OK, I goofed again.
> | 
> | It would be super-interesting to know whether CONFIG_DEBUG_SPINLOCK=n
> | improves things.
> 
> It does.   No stalls, hangs, or nmi's in several hours of running the
> test that previously failed on almost every run (with long stalls, system
> hangs, or NMI watchdogs), on the same hardware.
> 
> I made no other changes to the kernel config than turning both of
> the above off.
> 

Well isn't that interesting, thanks.   We have our 2.6.17.x patch.

Now we need to work out why.
