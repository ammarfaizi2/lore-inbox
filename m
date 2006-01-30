Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWA3SQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWA3SQp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 13:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWA3SQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 13:16:45 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:17615 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751275AbWA3SQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 13:16:44 -0500
Subject: Re: [PATCH 1/2] I2O: don't disable PCI device if it is enabled
	before probing
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43D566DB.2010103@shadowconnect.com>
References: <43D566DB.2010103@shadowconnect.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 30 Jan 2006 18:17:47 +0000
Message-Id: <1138645069.31089.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-01-24 at 00:29 +0100, Markus Lidel wrote:
> Changes:
> --------
> - If PCI device is enabled before probing, it will not be disabled at
>    exit.

Looks ok for this case but be warned that pdev->is_enabled is not a safe
check for many devices as the may be BIOS critical, or video for example
but not in the Linux list of things _it_ enabled.

