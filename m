Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbUBYBFT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 20:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262555AbUBYBFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:05:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:10925 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262253AbUBYBFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:05:07 -0500
Date: Tue, 24 Feb 2004 17:06:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3 hangs on  boot x440 (scsi?)
Message-Id: <20040224170645.392abcff.akpm@osdl.org>
In-Reply-To: <1077668801.2857.63.camel@cog.beaverton.ibm.com>
References: <20040222172200.1d6bdfae.akpm@osdl.org>
	<1077668801.2857.63.camel@cog.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz <johnstul@us.ibm.com> wrote:
>
> 	Booting 2.6.3-mm3 on an x440 hangs the box during the SCSI probe after
> the following:
>  
> scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
>         <Adaptec aic7899 Ultra160 SCSI adapter>                 
>         aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
>                                                                 
> 
> I went back to 2.6.3-mm1 (as it was a smaller diff) and the problem was
> there as well. 

Could you try reverting aic7xxx-deadlock-fix.patch?  Also, add
initcall_debug to the boot command just so we know we aren't blaming the
wrong thing.

Apart from that, gosh.  Maybe you could add just linus.patch and
bk-scsi.patch, see if that hangs too?  Or just test the latest linus tree -
the scsi changes were merged this morning.  Thanks.

