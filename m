Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVDCUBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVDCUBI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 16:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVDCUBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 16:01:08 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:24995 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261884AbVDCUBD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 16:01:03 -0400
X-ORBL: [69.107.61.180]
From: David Brownell <david-b@pacbell.net>
To: pavel@ucw.cz
Subject: Re: Re(2): fix u32 vs. pm message t in usb
Date: Sun, 3 Apr 2005 12:01:02 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <20050403193216.961D5194084@smtp.etmail.cz>
In-Reply-To: <20050403193216.961D5194084@smtp.etmail.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504031301.02179.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 April 2005 12:31 pm, pavel@ucw.cz wrote:
> Okay, you obviously have easy access to usb development trees...
> Do you think you could just take this patch as a basis and fix
> remaining u32 vs pm-message-t in usb? --p  

Fixing the "sparse -Wbitwise" messages, and addressing some other
behavior changes/bugs that crept in, was the idea.  That's already
done, but _without_ taking this as a basis (or breaking the sysfs
support etc).

The patches I sent fix everything I had time to test (just a subset
of the dozens of cases previously tested, probably covering the main
stuff that got broken) except the non-PCI platform_bus drivers where
pm_message_t has discarded essential functionality.  (Notably, info
about whether device clocks and/or power must be turned off.)

Fixing those will be more work than seems reasonable for 2.6.12
kernels.  Among other things, there's still a lot of stuff that
needs to percolate out to arch trees; designing and testing such
fixes takes time, as does percolating it back.

- Dave

p.s. PCI-express patches don't belong with USB patches.  :)

