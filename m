Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVG1N6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVG1N6W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 09:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVG1N4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 09:56:19 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:6325 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261447AbVG1NyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 09:54:21 -0400
Subject: Re: Fix up qla2xxx configuration bogosity
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux-SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050728051058.GA567@plap.qlogic.org>
References: <20050728051058.GA567@plap.qlogic.org>
Content-Type: text/plain
Date: Thu, 28 Jul 2005 09:53:48 -0400
Message-Id: <1122558828.5132.8.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-27 at 22:10 -0700, Andrew Vasquez wrote:
> Would you also apply the attached patch which adds the appropriate
> FW_LOADER pre-requisite and a separate entry for ISP24xx support.

That's what I see reading the code; however, it looks like it's *only*
the 24xx that needs it (qla24xx_load_risc_hotplug).  The patch below
pulls in the FW loader for every qlogic fibre driver, not just the
qla24xx; is there a reason for doing this?

James


