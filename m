Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268294AbTAMTCg>; Mon, 13 Jan 2003 14:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268297AbTAMTCg>; Mon, 13 Jan 2003 14:02:36 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:41006 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S268294AbTAMTCe>; Mon, 13 Jan 2003 14:02:34 -0500
Date: Mon, 13 Jan 2003 14:11:19 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200301131911.h0DJBJV16371@devserv.devel.redhat.com>
To: Patrik Staehli <lkml@pstaehli.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: usb-ohci mouse lockups on National Geode system
In-Reply-To: <mailman.1042478827.20208.linux-kernel2news@redhat.com>
References: <mailman.1042478827.20208.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We are experiencing usb mouse freezing with different 2.4.x kernels 
> (tested: 2.4.1, 2.4.17 and 2.4.20). In 2.4.20 it's actually much more 
> frequent than in the older ones.
> The freezing lockups only happen when the ide disk is active and the 
> mouse is being moved during that time.

Sounds like a bug in ohci, but it may be hard to track down.
In the meantime, use "hdparm -u 1 /dev/hda" in your boot scripts
as a workaround.

-- Pete
