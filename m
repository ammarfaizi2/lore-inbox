Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268604AbUHLQ35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268604AbUHLQ35 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 12:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268603AbUHLQ35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 12:29:57 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:25324 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S268601AbUHLQ3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 12:29:55 -0400
Subject: Re: [PATCH] SCSI midlayer power management
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nathan Bryant <nbryant@optonline.net>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20040812131457.GB1086@elf.ucw.cz>
References: <4119611D.60401@optonline.net>
	<20040811080935.GA26098@elf.ucw.cz> <411A1B72.1010302@optonline.net>
	<1092231462.2087.3.camel@mulgrave> <1092267400.2136.24.camel@gaston>
	<1092314892.1755.5.camel@mulgrave>  <20040812131457.GB1086@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 12 Aug 2004 12:29:28 -0400
Message-Id: <1092328173.2184.15.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 09:14, Pavel Machek wrote:
> Even read-only access could hurt.... That DMA engine is going to get
> very unhappy if we change data from under it, right?

But we're not planning to change this area of memory (it's a driver
allocated coherent mbox) until we power off the box, right? so it should
be just like a reboot today.

James


