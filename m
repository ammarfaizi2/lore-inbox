Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263049AbTI2XBN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 19:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263051AbTI2XBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 19:01:13 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:23523 "EHLO
	ponti.gallimedina.net") by vger.kernel.org with ESMTP
	id S263049AbTI2XBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 19:01:12 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: Peter Osterlund <petero2@telia.com>
Subject: Re: 2.6.0-test6-mm1: too many defunct event threads
Date: Tue, 30 Sep 2003 01:01:04 +0200
User-Agent: KMail/1.5.3
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
References: <200309292115.57918.gallir@uib.es> <200309292147.12595.gallir@uib.es> <m2d6dj1bif.fsf@p4.localdomain>
In-Reply-To: <m2d6dj1bif.fsf@p4.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309300101.04560.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 September 2003 00:21, Peter Osterlund shaped the electrons 
to shout:
> > Synaptics driver lost sync at 1st byte
> > Synaptics driver resynced.
> >
> > which are the only glitches I find to it.
>
> Did you try to modify the driver to use low packet rate reporting, ie
> 40 packets/s instead of 80?

Just tested, the same errors. 

Also confirmed that was configured to low rate by checking the interrupts 
rate, exactly half as before (220 vs 440 ints. per second).

So...?

minime:~# cat /proc/interrupts
           CPU0
  0:     310917          XT-PIC  timer
  1:        149          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          4          XT-PIC  rtc
 10:       2938          XT-PIC  yenta, yenta, uhci-hcd, Intel 
82801CA-ICH3, orinoco_cs
 11:          2          XT-PIC  ohci1394, uhci-hcd, uhci-hcd
 12:       9314          XT-PIC  i8042
 14:       5519          XT-PIC  ide0
NMI:          0
ERR:          0



-- 
  ricardo galli       GPG id C8114D34
  http://mnm.uib.es/~gallir/

