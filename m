Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267470AbTANHDr>; Tue, 14 Jan 2003 02:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267479AbTANHDr>; Tue, 14 Jan 2003 02:03:47 -0500
Received: from [195.141.26.14] ([195.141.26.14]:60429 "EHLO mars.planet.ch")
	by vger.kernel.org with ESMTP id <S267470AbTANHDq>;
	Tue, 14 Jan 2003 02:03:46 -0500
Message-ID: <3E23B857.30209@pstaehli.ch>
Date: Tue, 14 Jan 2003 08:12:23 +0100
From: Patrik Staehli <lkml@pstaehli.ch>
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: usb-ohci mouse lockups on National Geode system
References: <mailman.1042478827.20208.linux-kernel2news@redhat.com> <200301131911.h0DJBJV16371@devserv.devel.redhat.com>
In-Reply-To: <200301131911.h0DJBJV16371@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>We are experiencing usb mouse freezing with different 2.4.x kernels 
>>(tested: 2.4.1, 2.4.17 and 2.4.20). In 2.4.20 it's actually much more 
>>frequent than in the older ones.
>>The freezing lockups only happen when the ide disk is active and the 
>>mouse is being moved during that time.
> 
> Sounds like a bug in ohci, but it may be hard to track down.
> In the meantime, use "hdparm -u 1 /dev/hda" in your boot scripts
> as a workaround.

I tried it, but there are no noticeable improvements. This maybe 
indicates that it's a general interrupt timing problem with the ohci driver?

/Patrik

