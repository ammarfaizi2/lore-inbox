Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266339AbUBLLNb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 06:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUBLLNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 06:13:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38588 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266339AbUBLLN3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 06:13:29 -0500
Date: Thu, 12 Feb 2004 11:13:29 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Ulrich Windl <Ulrich.Windl@RZ.Uni-Regensburg.DE>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2: "filp->f_mode & 2..."
Message-ID: <20040212111329.GR21151@parcelfarce.linux.theplanet.co.uk>
References: <402B4FB2.mailxG23119XFU@pc5234.klinik.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402B4FB2.mailxG23119XFU@pc5234.klinik.uni-regensburg.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 12, 2004 at 11:04:34AM +0100, Ulrich Windl wrote:
> Hi everybody!
> 
> I think there's one thing to change in kernel sources; consider this:
> filp->f_mode & 2 || permission(filp->f_dentry->d_inode,2,NULL)

filp->f_mode & FMODE_WRITE
permission(...., MAY_WRITE, ...)
> 
> It's obvious to some, likely for others that "2" there really stands for
> "002", the good old UNIX write permission. I'd suggest either to write
> those permission bits in three-digit-octal, or introduce (maybe just use)
> symbolic constants for improved readability.
> 
> One could even consider a macro MAY_WRITE(filp):
> #define MAY_WRITE(filp) ((filp)->f_mode & WRITE_PERMISSION)
> #define WRITE_PERMISSION 002

Grep is such a wondeful thing...
