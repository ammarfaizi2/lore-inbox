Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965071AbVI3SuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbVI3SuM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 14:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbVI3SuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 14:50:12 -0400
Received: from smtpout.mac.com ([17.250.248.73]:17099 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S965066AbVI3SuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 14:50:09 -0400
In-Reply-To: <433D8542.1010601@adaptec.com>
References: <Pine.LNX.4.10.10509300015100.27623-100000@master.linux-ide.org> <433D8542.1010601@adaptec.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A0262C6F-6B0E-4790-BA42-FAFD6F026E0A@mac.com>
Cc: Andre Hedrick <andre@linux-ide.org>,
       "David S. Miller" <davem@davemloft.net>, jgarzik@pobox.com,
       willy@w.ods.org, patmans@us.ibm.com, ltuikov@yahoo.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into the kernel
Date: Fri, 30 Sep 2005 14:50:27 -0400
To: Luben Tuikov <luben_tuikov@adaptec.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 30, 2005, at 14:34:42, Luben Tuikov wrote:
> This is how we have the SPI-centric EH methods in the scsi host  
> template right now:
>     int (* eh_abort_handler)(struct scsi_cmnd *);
>     int (* eh_device_reset_handler)(struct scsi_cmnd *);
>     int (* eh_bus_reset_handler)(struct scsi_cmnd *);
>     int (* eh_host_reset_handler)(struct scsi_cmnd *);

So submit patches to fix it!  You clearly understand what is wrong,  
so why not help change it?

> But we should _not_ break legacy drivers and backward support,

WRONG.  This is not the way Linux works.  We break internal APIs all  
the time.  If you need to change one _thats_OK_.  Userspace ABI is  
mostly another matter, but that's different from the internal data  
structures and functions.

> The way we do this is we slowly, without disruption to older  
> drivers introduce, in parallel, emerge a new, simpler, slimmer,  
> faster SCSI Core, whereby we accommodate new infrastructures, yet,  
> have 100% backward compatibility, via the current older SCSI Core.   
> After all, both would be a bunch of functions in a bunch of files.

Except this introduces bloat and multiplies maintainer load.  Fix the  
existing one.  If it breaks other in-core drivers, fix those to  
match.  If it breaks out-of-tree drivers, too bad!  They should get  
their code upstream and then they wouldn't need to worry.

> If X works with Y, do not disrupt it.  Fix it if it's broken.   
> Introduce innovation, functionality, better design, but not at the  
> expense of breaking legacy.

This is not the way Linux works.  It may be the way Adaptec works,  
but that's not relevant here.

> Section 4: Politics
> -------------------

s/Politics.*//g;  I hate politics.  Keep it off this list.

Cheers,
Kyle Moffett

