Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266296AbUBLKDI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 05:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266324AbUBLKDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 05:03:08 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:19128 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S266296AbUBLKDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 05:03:06 -0500
Date: Thu, 12 Feb 2004 11:04:34 +0100
To: linux-kernel@vger.kernel.org
Subject: 2.6.2: "filp->f_mode & 2..."
Message-ID: <402B4FB2.mailxG23119XFU@pc5234.klinik.uni-regensburg.de>
User-Agent: nail 10.5 4/27/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Ulrich.Windl@RZ.Uni-Regensburg.DE (Ulrich Windl)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody!

I think there's one thing to change in kernel sources; consider this:
filp->f_mode & 2 || permission(filp->f_dentry->d_inode,2,NULL)

It's obvious to some, likely for others that "2" there really stands for
"002", the good old UNIX write permission. I'd suggest either to write
those permission bits in three-digit-octal, or introduce (maybe just use)
symbolic constants for improved readability.

One could even consider a macro MAY_WRITE(filp):
#define MAY_WRITE(filp) ((filp)->f_mode & WRITE_PERMISSION)
#define WRITE_PERMISSION 002

Regards,
Ulrich

