Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267705AbTGONq7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 09:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267765AbTGONq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 09:46:59 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:63405 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267705AbTGONq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 09:46:58 -0400
Date: Tue, 15 Jul 2003 16:01:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Peter Osterlund <petero2@telia.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Incorrect timeout in CDROM_SEND_PACKET ioctl in 2.5 kernels
Message-ID: <20030715140150.GW833@suse.de>
References: <m2u19q1k3b.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2u19q1k3b.fsf@telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13 2003, Peter Osterlund wrote:
> The CDROM_SEND_PACKET ioctl passes a struct cdrom_generic_command from
> user space, which contains a timeout field. The timeout is measured in
> jiffies, but the conversion from user to kernel jiffies is missing,
> which makes the timeout 10 times shorter than it should be in 2.5
> kernels on x86. This causes CDRW formatting with cdrwtool to fail. The
> following patch fixes this problem.

Looks fine, applied.

-- 
Jens Axboe

