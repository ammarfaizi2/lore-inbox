Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264957AbTF3HiZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 03:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265079AbTF3HiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 03:38:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51128 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264957AbTF3HiW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 03:38:22 -0400
Date: Mon, 30 Jun 2003 08:52:42 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Trying to improve /proc/filesystems
Message-ID: <20030630075242.GM27348@parcelfarce.linux.theplanet.co.uk>
References: <D9B4591FDBACD411B01E00508BB33C1B0140536F@mesadm.epl.prov-liege.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9B4591FDBACD411B01E00508BB33C1B0140536F@mesadm.epl.prov-liege.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 30, 2003 at 09:21:00AM +0200, Frederick, Fabian wrote:
> Hi,
> 	I'm trying to do 
> 
> nodev		xxx	0
> 		yyy	2
> (or replace nodev by 0->x)
> 
> with the following but Linux complains : VFS : unable to mount
> root....Someone could help ?

Yes.  Layout of files in procfs should be treated as a part of ABI.
IOW, you make incompatible change - things break.

Folks, file in /proc is not different from a syscall in that respect -
changing layout has the same effect as changes of layout in syscall
arguments.

IOW, don't do that.
