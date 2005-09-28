Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbVI1PFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbVI1PFQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 11:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbVI1PFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 11:05:16 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:49574 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751039AbVI1PFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 11:05:14 -0400
Subject: Re: Infinite interrupt loop, INTSTAT = 0
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Olivier Galibert <galibert@pobox.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "Hack inc." <linux-kernel@vger.kernel.org>
In-Reply-To: <20050928134514.GA19734@dspnet.fr.eu.org>
References: <20050928134514.GA19734@dspnet.fr.eu.org>
Content-Type: text/plain
Date: Wed, 28 Sep 2005 10:05:08 -0500
Message-Id: <1127919909.4852.7.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-28 at 15:45 +0200, Olivier Galibert wrote:
> Sep 28 15:26:13 m82 kernel: scsi1:0:0:0: Attempting to abort cmd ffff8100bfe3e300: 0x28 0x0 0x0 0x50 0x0 0x3f 0x0 0x0 0x8 0x0
> Sep 28 15:26:13 m82 kernel: Infinite interrupt loop, INTSTAT = 0scsi1: At time of recovery, card was not paused
> Sep 28 15:26:13 m82 kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<

What was it doing before this?  i.e. what were all the messages from the
card.  The message happens when the aic driver is unable to clear its
pending workqueue after it suspends ... which is part of error recovery.
So, what error was it trying to recover from?

By the way, your AIC-7892 is a different driver.

James


