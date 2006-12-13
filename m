Return-Path: <linux-kernel-owner+w=401wt.eu-S964876AbWLMMFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWLMMFp (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 07:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWLMMFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 07:05:45 -0500
Received: from brick.kernel.dk ([62.242.22.158]:10771 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964876AbWLMMFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 07:05:44 -0500
Date: Wed, 13 Dec 2006 13:07:04 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: mike.miller@hp.com, mikem@beardog.cca.cpqcorp.net
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2/2] cciss: remove calls to pci_disable_device
Message-ID: <20061213120703.GN4576@kernel.dk>
References: <20061212195458.GB2471@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061212195458.GB2471@beardog.cca.cpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12 2006, Mike Miller (OS Dev) wrote:
> PATCH 2/2
> 
> This patch removes calls to pci_disable_device except in
> fail_all_cmds. The pci_disable_device function does something nasty to
> Smart Array controllers that pci_enable_device does not undo. So if
> the driver is unloaded it cannot be reloaded.  Also, customers can
> disable any pci device via the ROM Based Setup Utility (RBSU). If the
> customer has disabled the controller we should not try to blindly
> enable the card from the driver.  Please consider this for inclusion.

Applied 1+2 for inclusion.

-- 
Jens Axboe

