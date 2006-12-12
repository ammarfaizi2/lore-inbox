Return-Path: <linux-kernel-owner+w=401wt.eu-S1750998AbWLLJEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWLLJEt (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 04:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWLLJEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 04:04:49 -0500
Received: from plusavs02.SBG.AC.AT ([141.201.10.77]:43132 "HELO
	plusavs02.sbg.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750998AbWLLJEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 04:04:48 -0500
Subject: Re: get device from file struct
From: Silviu Craciunas <silviu.craciunas@sbg.ac.at>
Reply-To: silviu.craciunas@sbg.ac.at
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <457DA4A0.4060108@ens-lyon.org>
References: <1165850548.30185.18.camel@ThinkPadCK6>
	 <457DA4A0.4060108@ens-lyon.org>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 10:04:08 +0100
Message-Id: <1165914248.30185.41.camel@ThinkPadCK6>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Dec 2006 09:04:36.0695 (UTC) FILETIME=[8C40F670:01C71DCC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-11 at 19:34 +0100, Brice Goglin wrote:
> Silviu Craciunas wrote:
> > quick question for the gurus.. is it possible to determine the hardware
> > device from a file struct during read/write system call. For example in
> > fs/read_write.c when doing a vfs_read.  
> >   
> 
> file->f_dentry->d_inode gives you the inode. If the inode is on top of a
> block device, inode->i_bdev gives you a struct block_device that might
> help you.
> 
> Brice

thanks for the reply, the block device can be determined with the major
and minor numbers , what I would be more interested in is if one can get
the net_device struct from the file struct

silviu

