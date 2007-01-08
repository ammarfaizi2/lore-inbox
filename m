Return-Path: <linux-kernel-owner+w=401wt.eu-S932675AbXAHVDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932675AbXAHVDa (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbXAHVDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:03:30 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:34491 "EHLO
	fr.zoreil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932664AbXAHVD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:03:29 -0500
Date: Mon, 8 Jan 2007 22:01:12 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Dmitriy Monakhov <dmonakhov@sw.ru>
Cc: linux-kernel@vger.kernel.org, zambrano@broadcom.com
Subject: Re: [PATCH] Broadcom 4400 resume small fix
Message-ID: <20070108210112.GB28440@electric-eye.fr.zoreil.com>
References: <87lkkdv61q.fsf@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lkkdv61q.fsf@sw.ru>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitriy Monakhov <dmonakhov@sw.ru> :
> Return value  of 'pci_enable_device' was ignored in b44_resume().
> We can't ingore it because it can fail.

- Please Cc: netdev@vger.kernel.org, jeff@garzik.org and the maintainer
  of the driver (Gary Zambrano <zambrano@broadcom.com> as per MAINTAINERS
  file and the log of the driveri).
- the dev_err() message fits completely on a 80 columns line.
- request-irq is not checked a few lines below either.

It would be nice to avoid the free_irq/pci_disable_device dance altogether.

-- 
Ueimor
