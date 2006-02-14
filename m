Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422646AbWBNQrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422646AbWBNQrl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 11:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422645AbWBNQrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 11:47:40 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:1155 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422643AbWBNQrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 11:47:39 -0500
Subject: Re: [PATCH] ide: Allow IDE interface to specify its not capable of
	32-bit operations
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0602141022000.27351-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0602141022000.27351-100000@gate.crashing.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Feb 2006 16:50:28 +0000
Message-Id: <1139935828.10394.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-02-14 at 10:22 -0600, Kumar Gala wrote:
> In some embedded systems the IDE hardware interface may only support 16-bit
> or smaller accesses.  Allow the interface to specify if this is the case
> and don't allow the drive or user to override the setting.

The "no_io_32bit" is just a dead leftover. It has no effect at all
anyway so this patch is a bit pointless.



Do a grep over the code for no_io_32bit and you will see its essentially
a private variable in the CMD640 driver.

