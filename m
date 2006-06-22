Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWFVFqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWFVFqA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 01:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWFVFp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 01:45:59 -0400
Received: from osa.unixfolk.com ([209.204.179.118]:56464 "EHLO
	osa.unixfolk.com") by vger.kernel.org with ESMTP id S932260AbWFVFp7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 01:45:59 -0400
Date: Wed, 21 Jun 2006 22:45:49 -0700 (PDT)
From: Dave Olson <olson@unixfolk.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@elte.hu, ccb@acm.org, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Subject: Re: [patch] increase spinlock-debug looping timeouts (write_lock
 and NMI)
Message-ID: <Pine.LNX.4.61.0606212243240.32136@osa.unixfolk.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006, Andrew Morton wrote:
| > Intended to be more or less stock fc4 but with CONFIG_PCI_MSI=y and
| > 2.6.17-based patch so the 8131 MSI quirk isn't enabled.
| > 
| > >From the config file:
| > 	CONFIG_DEBUG_SPINLOCK=y
| > 	CONFIG_DEBUG_SPINLOCK_SLEEP=y
| 
| OK, I goofed again.
| 
| It would be super-interesting to know whether CONFIG_DEBUG_SPINLOCK=n
| improves things.

It does.   No stalls, hangs, or nmi's in several hours of running the
test that previously failed on almost every run (with long stalls, system
hangs, or NMI watchdogs), on the same hardware.

I made no other changes to the kernel config than turning both of
the above off.

Dave Olson
olson@unixfolk.com
http://www.unixfolk.com/dave
