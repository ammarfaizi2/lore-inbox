Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267934AbUJDOEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267934AbUJDOEk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 10:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267935AbUJDOEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 10:04:40 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:62642 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267934AbUJDOEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 10:04:37 -0400
Date: Mon, 4 Oct 2004 16:01:46 +0200
From: Jens Axboe <axboe@suse.de>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug#274860: Acknowledgement (kernel-image-2.6.8-1-686: CDROM_SEND_PACKET ioctls only work as root)
Message-ID: <20041004140145.GY2287@suse.de>
References: <E1CES9w-0005Lh-6f@lkcl.net> <handler.274860.B.10968930694757.ack@bugs.debian.org> <20041004131014.GF19341@lkcl.net> <20041004135326.GA20930@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041004135326.GA20930@lkcl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04 2004, Luke Kenneth Casson Leighton wrote:
> found it.
> 
> it's a new piece of kernel code verify_command in
> drivers/block/scsi_ioctl.c, which checks for the capability
> CAP_SYS_RAWIO.
> 
> ah, dammit.
> 
> for k3b to work, you'd have to install it setuid root, call
> getcap(), remove all but the necessary capabilities (i.e. don't
> remove CAP_SYS_RAWIO), do a setfsuid() and setfsgid() and do
> a setcap().

it works in 2.6.9-rcX.

-- 
Jens Axboe

