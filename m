Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130733AbRDBUv6>; Mon, 2 Apr 2001 16:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131248AbRDBUvt>; Mon, 2 Apr 2001 16:51:49 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:48132 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S130733AbRDBUvk>; Mon, 2 Apr 2001 16:51:40 -0400
Message-Id: <200104022050.f32KoRs93074@aslan.scsiguy.com>
To: Douglas Gilbert <dougg@torque.net>
cc: Peter Daum <gator@cs.tu-berlin.de>, linux-kernel@vger.kernel.org,
   linux-scsi@vger.kernel.org
Subject: Re: scsi bus numbering 
In-Reply-To: Your message of "Sun, 01 Apr 2001 17:03:55 EDT."
             <3AC797BB.D2AA2FE4@torque.net> 
Date: Mon, 02 Apr 2001 14:50:27 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The intent is that all built in HBA drivers are
>initialized _before_ the built in upper level 
>drivers (e.g. sd). To get the effect you describe
>the driver init order seems to have been:
>  register ncr53c8xxx
>  register sd
>  register aic7xxx      # too late ...

It is bogus that this stuff depends on link order to function
correctly.  The driver is built and linked into the kernel in its
current fashion to satisfy Linus' desire to make drivers as independant
from the SCSI Makefile and Config file as possible.  I've modified
how the driver is built for the 6.1.9 driver release so it will be
linked in prior to the top level drivers.

--
Justin
