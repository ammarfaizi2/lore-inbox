Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWCBKdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWCBKdJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 05:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWCBKdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 05:33:09 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:18042 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751431AbWCBKdH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 05:33:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Pz5R3f86DRF38/hP/AT5AcbWraBJnRbnL1nPm2uTnBXYvlFahUoRwvYArK9n82qJl+BGeQN0Bw7ADXdf/Np19HShK0OCHNPj7hgciEUYOELtZCYKOI4mxaArYl+Du7IIFODkiUiEmvm/jGq7iwXyIWx+q25bdqosNeKExMvpn6Q=
Message-ID: <7c3341450603020232ocd76820y@mail.gmail.com>
Date: Thu, 2 Mar 2006 10:32:59 +0000
From: "Nick Warne" <nick@linicks.net>
Reply-To: "Nick Warne" <nick@linicks.net>
To: "Mark Lord" <lkml@rtr.ca>
Subject: Re: hda: irq timeout: status=0xd0 DMA question
Cc: "Henrik Persson" <root@fulhack.info>, "Robert Hancock" <hancockr@shaw.ca>,
       "Jesper Juhl" <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200602271832.22186.nick@linicks.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602261308.47513.nick@linicks.net>
	 <200602262110.55324.nick@linicks.net> <4402FF89.4070009@rtr.ca>
	 <200602271832.22186.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now to wait and see the drive produce the error.


OK, that doesn't work - it appears all get reset anyway.  Both drives
here had -K1 and -k1 set with hdparm:


Mar  2 10:28:29 website2 kernel: blk: queue c033da3c, I/O limit 4095Mb
(mask 0xffffffff)
Mar  2 10:28:29 website2 kernel: hda: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Mar  2 10:28:29 website2 kernel:
Mar  2 10:28:29 website2 kernel: hda: drive not ready for command
Mar  2 10:28:29 website2 kernel: hda: status timeout: status=0xd0 { Busy }
Mar  2 10:28:29 website2 kernel:
Mar  2 10:28:29 website2 kernel: hda: DMA disabled
Mar  2 10:28:29 website2 kernel: hdb: DMA disabled
Mar  2 10:28:29 website2 kernel: hda: drive not ready for command
Mar  2 10:28:29 website2 kernel: ide0: reset: success


[nick@website2 nick]$ sudo /sbin/hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  0 (off)
 keepsettings =  1 (on)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 784/255/63, sectors = 12594960, start = 0


[nick@website2 nick]$ sudo /sbin/hdparm /dev/hdb

/dev/hdb:
 multcount    =  0 (off)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  0 (off)
 keepsettings =  1 (on)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 525/255/63, sectors = 8439184, start = 0



Nick
