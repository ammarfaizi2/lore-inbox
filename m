Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318529AbSHPQTa>; Fri, 16 Aug 2002 12:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318536AbSHPQTa>; Fri, 16 Aug 2002 12:19:30 -0400
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:41121 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S318529AbSHPQT3>; Fri, 16 Aug 2002 12:19:29 -0400
Message-ID: <3D5D26DE.7140941B@wanadoo.fr>
Date: Fri, 16 Aug 2002 18:22:54 +0200
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-pre2 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: Tomas Szepe <szepe@pinerecords.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre2-ac3 stops responding
References: <3D5CFE83.136D81FC@wanadoo.fr> <20020816152641.GE11155@louise.pinerecords.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe wrote:
> 
> > with 2.4.20-pre2 : 30s
> > with 2.4.30-pre2-ac3 : 55s
> 
> Do you get DMA on your IDE disks at all?
> 
> hdparm -iv /dev/hdX
> 
> T.

Seems to have a problem with DMA

[root@debian-f5ibh] ~ # hdparm -iv /dev/hda2

/dev/hda2:
multcount    =  1 (on)
IO_support   =  1 (32-bit)
unmaskirq    =  0 (off)
using_dma    =  0 (off)
keepsettings =  0 (off)
readonly     =  0 (off)
readahead    =  8 (on)
geometry     = 3649/255/63, sectors = 29302560, start = 9767520
HDIO_GET_IDENTITY failed: Invalid argument

[root@debian-f5ibh] ~ # hdparm -d1 /dev/hda2

/dev/hda2:
setting using_dma to 1 (on)
HDIO_SET_DMA failed: Invalid argument
using_dma    =  0 (off)
