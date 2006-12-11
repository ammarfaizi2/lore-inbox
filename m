Return-Path: <linux-kernel-owner+w=401wt.eu-S936815AbWLKSeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936815AbWLKSeY (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 13:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937444AbWLKSeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 13:34:24 -0500
Received: from iona.labri.fr ([147.210.8.143]:60381 "EHLO iona.labri.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936815AbWLKSeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 13:34:23 -0500
Message-ID: <457DA4A0.4060108@ens-lyon.org>
Date: Mon, 11 Dec 2006 19:34:08 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: silviu.craciunas@sbg.ac.at
CC: linux-kernel@vger.kernel.org
Subject: Re: get device from file struct
References: <1165850548.30185.18.camel@ThinkPadCK6>
In-Reply-To: <1165850548.30185.18.camel@ThinkPadCK6>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Silviu Craciunas wrote:
> quick question for the gurus.. is it possible to determine the hardware
> device from a file struct during read/write system call. For example in
> fs/read_write.c when doing a vfs_read.  
>   

file->f_dentry->d_inode gives you the inode. If the inode is on top of a
block device, inode->i_bdev gives you a struct block_device that might
help you.

Brice

