Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVAaOUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVAaOUS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 09:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVAaOUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 09:20:18 -0500
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:53695 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261209AbVAaOUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 09:20:14 -0500
Subject: Re: [PATCH] Resume from initramfs
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41FE3C34.4000200@suse.de>
References: <41FE24F5.5070906@suse.de> <20050131125110.GD6279@elf.ucw.cz>
	 <41FE3C34.4000200@suse.de>
Content-Type: text/plain
Date: Mon, 31 Jan 2005 14:18:37 +0000
Message-Id: <1107181117.9518.2.camel@elrond.flymine.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-31 at 15:09 +0100, Hannes Reinecke wrote:

> swsusp_check is used by both entry points, and is itself not a init 
> function.
> I simply found it bad style to reference a __init function from there.
> And name_to_dev_t is evil in itself. I'd gladly be rid of it if possible.

name_to_dev_t won't work once userspace has started - you need to
set_fs(KERNEL_DS) at least one of the calls in it, IIRC.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

