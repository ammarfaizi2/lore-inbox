Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265196AbSKSLVl>; Tue, 19 Nov 2002 06:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265198AbSKSLVl>; Tue, 19 Nov 2002 06:21:41 -0500
Received: from leon-2.mat.uni.torun.pl ([158.75.2.64]:38625 "EHLO
	leon-2.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id <S265196AbSKSLVk>; Tue, 19 Nov 2002 06:21:40 -0500
Date: Tue, 19 Nov 2002 12:28:18 +0100 (CET)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@Jan
To: Peter Waechtler <pwaechtler@mac.com>
cc: Michal Wronski <wrona@mat.uni.torun.pl>, <linux-kernel@vger.kernel.org>,
       "Gustafson, Geoffrey R" <geoffrey.r.gustafson@intel.com>,
       "Abbas, Mohamed" <mohamed.abbas@intel.com>
Subject: Re: [PATCH] unified SysV and POSIX mqueues - complete rewrite
In-Reply-To: <3DD2D154.AB45F0CD@mac.com>
Message-ID: <Pine.GSO.4.40.0211191219060.17529-100000@Jan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

After some looking into your code, I think there is a bug.
Please correct me if I'm wrong.

The problem occur when awake processes which wait for message (or free
space). I think that your code will wake them up in random order. POSIX
says:

> If more than one thread is waiting to send when space becomes
> available in the message queue and the Priority Scheduling option is
> supported, then the thread of the highest priority that has been
> waiting the longest shall be unblocked to send its message

I've written a test and it shows that my suspects are rather true?

BTW: I've had some problems with your patch when linking kernel - in your
main file were used static functions from msg.c?? Maybe my patch (taken
from lkml - post date: XI 10) was incomplete? If there is more recent
version could you inform me? Thanks.

Regards

K. Benedzyczak



