Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267973AbUJSFHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267973AbUJSFHW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 01:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267971AbUJSFHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 01:07:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:2744 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267961AbUJSFHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 01:07:15 -0400
Date: Mon, 18 Oct 2004 22:05:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com,
       torvalds@osdl.org, linux-scsi@vger.kernel.org, willy@debian.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [BK PATCH] SCSI updates for 2.6.9
Message-Id: <20041018220521.3555fb7b.akpm@osdl.org>
In-Reply-To: <200410182341.13648.dtor_core@ameritech.net>
References: <1098137016.2011.339.camel@mulgrave>
	<200410182341.13648.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>
> On Monday 18 October 2004 05:03 pm, James Bottomley wrote:
> 
> > Matthew Wilcox:
> >   o Add SPI-5 constants to scsi.h
> 
> This breaks Firewire SBP2 build:

Insert grumpy comment wrt testing in -mm.

>   CC [M]  drivers/ieee1394/sbp2.o
> In file included from drivers/ieee1394/sbp2.c:78:
> drivers/ieee1394/sbp2.h:61:1: warning: "ABORT_TASK_SET" redefined
> In file included from drivers/scsi/scsi.h:31,
>                  from drivers/ieee1394/sbp2.c:67:
> include/scsi/scsi.h:255:1: warning: this is the location of the previous definition
> In file included from drivers/ieee1394/sbp2.c:78:
> drivers/ieee1394/sbp2.h:62:1: warning: "LOGICAL_UNIT_RESET" redefined
> In file included from drivers/scsi/scsi.h:31,
>                  from drivers/ieee1394/sbp2.c:67:
> include/scsi/scsi.h:267:1: warning: this is the location of the previous definition
> 
> It looks like firewire has its own set of commands with conflicting names.
> Who should win?

Probably 1394 should be using less generic-looking names.

I assume this patch broke drivers/s390/scsi/zfcp_def.h as well.
