Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWDTHuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWDTHuJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 03:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWDTHuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 03:50:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60384 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750765AbWDTHuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 03:50:08 -0400
Date: Thu, 20 Apr 2006 00:49:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ken Witherow <ken@krwtech.com>
Cc: phantoml@rochester.rr.com, linux-kernel@vger.kernel.org
Subject: Re: Advansys SCSI driver and 2.6.16
Message-Id: <20060420004915.45cd34be.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604200242410.3134@death>
References: <Pine.LNX.4.64.0604191444200.1841@death>
	<20060419163247.6986a87c.akpm@osdl.org>
	<20060419224202.3e2f99f5.akpm@osdl.org>
	<Pine.LNX.4.64.0604200242410.3134@death>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken Witherow <phantoml@rochester.rr.com> wrote:
>
> I would say driver is working as intended,

OK, thanks.  The driver needs some caring for.  Probably marking it as
BROKEN was the wrong thing to do, because then everyone ignores it.  I'll
enable it in -mm, see if that motivates someone to take pity upon it.

> though I do get a slew of:
> 
>  drivers/scsi/advansys.c:18223: warning: passing argument 2 of 'writew' 
>  makes pointer from integer without a cast
>  drivers/scsi/advansys.c:18223: warning: passing argument 2 of 'writeb' 
>  makes pointer from integer without a cast
>
>  warnings when compiling

Yes, you will.   I stuck a few typecasts in there just to quieten things down.

