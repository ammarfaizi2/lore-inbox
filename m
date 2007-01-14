Return-Path: <linux-kernel-owner+w=401wt.eu-S1751232AbXANKkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbXANKkv (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 05:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbXANKkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 05:40:51 -0500
Received: from www.osadl.org ([213.239.205.134]:34240 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751210AbXANKku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 05:40:50 -0500
Subject: Re: 2.6.20-rc4-mm1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org,
       axboe@kernel.dk
In-Reply-To: <1168768104.2941.53.camel@localhost.localdomain>
References: <20070111222627.66bb75ab.akpm@osdl.org>
	 <1168768104.2941.53.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 14 Jan 2007 11:46:57 +0100
Message-Id: <1168771617.2941.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2007-01-14 at 10:48 +0100, Thomas Gleixner wrote:
> ata_scsi_rbuf_get requests KM_IRQ0 type memory and calls kmap_atomic
> with interrupts enabled.
> 
> Boot proceeds, but gets stuck hard at:
> "Remounting root filesystem in read-write mode:"
> 
> No SysRq-T, nothing.
> 
> The above BUG seems unrelated to that. Investigating further.

Bisect identified: git-block.patch

	tglx


