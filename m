Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264260AbUFPW31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbUFPW31 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 18:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266339AbUFPW31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 18:29:27 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:4256 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S264260AbUFPW2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 18:28:03 -0400
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MIME::Lite 1.4  (F2.72; T1.001; A1.62; B3.01; Q3.01)
Subject: Bug: SCSI driver hangs in 2.6.6 and 2.6.7
To: linux-kernel@vger.kernel.org
Date: Wed, 16 Jun 2004 17:28:02 -0500
From: "Kai OM" <epimetreus@fastmail.fm>
X-Sasl-Enc: mIUn3eKms722urNio8NhaQ 1087424882
Message-Id: <1087424882.30041.198581042@webmail.messagingengine.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like there is some kind of bug in sym 2.1.18j that
prevents booting on some SCSI controllers.

I've tested my SCSI controller (LSIU160) against 2.6.7 and 2.6.6, and
both are proneto this bug. All kernel versions prior to this work
perfectly, as does Windows. The hard drive on that controller is a
Quantum ATLAS10K2-TY734J, in case it's pertinent.

I have no clue what the issue is, precisely, or if there's some obscure
bug in the firmware I'm using(LSI Logic's 4.19 - the latest version I
was able to find). Some Googling returned no results, so I have to
assume otherwise.

[PATCH] sym 2.1.18j sym 2.1.18j: 
- Add SPI
transport attributes (James Bottomley) 
- Use generic code to do Domain Validation (James Bottomley) 
- Stop using scsi_to_pci_dma_dir() (Christoph Hellwig) 
- Change some constants to their symbolic names (Grant Grundler) 
- Handle a race between a postponed command completing and the EH
retrying it (James Bottomley)
- If the auto request sense fails, issue a device reset (James
Bottomley) 

I'm not any fool's expert on SCSI, nor coding, so I can't really guess
what changes that weremade are the culprit, and since I don't know where
to get a copy of the patch that was submitted, I can't try reversing the
changes it made. If someone wants to link me to this patch, I'd be
interested to try that and see if it has any effect. 

I've already posted about this once, but I suspect it might have looked
a little like begging for "tech support", instead of reporting an actual
bug to some people, so I am guessing it was largely ignored. 

Anyway, I'd really like to, you know, use kernel versions after 2.6.5,
because that would rather severely
limit my ability to stay up-to-date in the Linux world after awhile.

 Thanks for any consideration this gets.
