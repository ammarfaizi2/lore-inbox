Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262261AbVAIGS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbVAIGS5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 01:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVAIGS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 01:18:57 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:18061 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262261AbVAIGSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 01:18:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=HBTsnw0Of5V2XzLIGt8MisPIGc69R39C7J1w6W9h0e0/PUTV4I9BrpnbEp/YjBZiSj1I0YpQOH3d3ViZXsd9aKzrUpUALzdrBWa4MNKaubct4+y++L/plt4FrbOFi1sGvSqwQ7KZ3J+RZP77+wWd3fkvzeusOIw+khwH0LebMCM=
Message-ID: <5a4c581d05010822181b58b3d4@mail.gmail.com>
Date: Sun, 9 Jan 2005 07:18:54 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: CONFIG_SCSI_QLA2<tripleX> looks dead - could it be removed ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050109060531.GN14108@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <5a4c581d050108214866117e3a@mail.gmail.com>
	 <20050109060531.GN14108@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jan 2005 07:05:31 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> On Sun, Jan 09, 2005 at 06:48:41AM +0100, Alessandro Suardi wrote:
> 
> > Hoping that this time the gmail filter doesn't bounce my subject (doh)
> >
> > Said entry only appears in defconfigs, but doesn't seem to be actually
> > used by anyone - at least according to this grep:
> >
> > [asuardi@incident linux]$ find . -type f | xargs grep
> > CONFIG_SCSI_QLA2XXX | grep -v defconfig
> 
> Correct grep command:
>    grep -r SCSI_QLA2XXX * | grep -v defconfig

Thanks - it shows I should go to bed after watching the NFL wildcards...

> > ./drivers/scsi/Makefile:obj-$(CONFIG_SCSI_QLA2XXX)      += qla2xxx/
> > ./include/linux/autoconf.h:#define CONFIG_SCSI_QLA2XXX_MODULE 1
> > ./.config:CONFIG_SCSI_QLA2XXX=m
> > ./.config.old:CONFIG_SCSI_QLA2XXX=m
> > [asuardi@incident linux]$
> >
> > Moreover, there doesn't seem to be any entry in kbuild menus to
> >  turn it off. Even taking it out of my .config and running oldconfig
> >  brings it back in.
> 
> You missed drivers/scsi/qla2xxx/Kconfig .

Ah, I see, thanks.

So, if I'm saying CONFIG_SCSI=m for USB storage I get an unwanted
 CONFIG_SCSI_QLA2XXX=m without any way to turn it off.

Well, as long as it's harmless...

--alessandro
 
 "And every dream, every, is just a dream after all"
  
    (Heather Nova, "Paper Cup")
