Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWFAWuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWFAWuF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 18:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWFAWuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 18:50:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45288 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750833AbWFAWuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 18:50:03 -0400
Date: Thu, 1 Jun 2006 15:52:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: jesper.juhl@gmail.com, linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: 2.6.17-rc5-mm2
Message-Id: <20060601155250.7dbcc6ef.akpm@osdl.org>
In-Reply-To: <986ed62e0606011532kdeba801l57c1867c54b2be87@mail.gmail.com>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	<9a8748490606011451m69e2f437uf3822e535f87d9ae@mail.gmail.com>
	<986ed62e0606011532kdeba801l57c1867c54b2be87@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Barry K. Nathan" <barryn@pobox.com> wrote:
>
> On 6/1/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > Got a few build warnings with this one :
> 
> My build finished; I got this warning during make modules_install:
> 
> if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F
> System.map  2.6.17-rc5-mm2; fi
> WARNING: /lib/modules/2.6.17-rc5-mm2/kernel/drivers/scsi/libsrp.ko
> needs unknown symbol scsi_tgt_queue_command
> 

Please send `grep SCSI .config'.

I'd be guessing that either SCSI_SRP needs to depend upon SCSI_TGT or we
need a stub function for scsi_tgt_queue_command(), for when SCSI_TGT
is undefined.
