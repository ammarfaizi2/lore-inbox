Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262513AbSI0ScK>; Fri, 27 Sep 2002 14:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262517AbSI0ScJ>; Fri, 27 Sep 2002 14:32:09 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:17399 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262513AbSI0ScJ>; Fri, 27 Sep 2002 14:32:09 -0400
Subject: Re: [OT]Raw Disk Support?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: markh@compro.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D945F48.5DC9D233@compro.net>
References: <3D945F48.5DC9D233@compro.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Sep 2002 15:21:45 +0100
Message-Id: <1033136505.16040.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-27 at 14:38, Mark Hounschell wrote:
> I guess first, will a Linux scsi driver let me read 768 byte sectors and second
> is there raw disk device support such that I can read these disks without a
> known filesystem type being on them?

Our raw drivers dont support non power of two sectors. You can extract
all the data itself using the scsi generic interface to send your own
SCSI READ_6 commands to the drive directly

