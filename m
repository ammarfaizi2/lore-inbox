Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316961AbSGSTSP>; Fri, 19 Jul 2002 15:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316965AbSGSTSP>; Fri, 19 Jul 2002 15:18:15 -0400
Received: from mtiwmhc23.worldnet.att.net ([204.127.131.48]:10677 "EHLO
	mtiwmhc23.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S316961AbSGSTSM>; Fri, 19 Jul 2002 15:18:12 -0400
Date: Fri, 19 Jul 2002 15:27:07 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc2-ac2
Message-ID: <20020719192707.GA22951@lnuxlab.ath.cx>
References: <200207181935.g6IJZrZ06774@devserv.devel.redhat.com> <E17VYzf-0001wE-00@tahoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17VYzf-0001wE-00@tahoe.alcove-fr>
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling 2.4.19-rc2-ac2 I got the following warning:

ksyms.c:15:1: warning: "smp_num_cpus" redefined
In file included from /usr/src/linux-2.4-ac/include/linux/sched.h:23,
                 from /usr/src/linux-2.4-ac/include/linux/mm.h:4,
                 from /usr/src/linux-2.4-ac/include/linux/slab.h:14,
                 from ksyms.c:13:
/usr/src/linux-2.4-ac/include/linux/smp.h:80:1: warning: this is the location of the previous definition

When I looked at ksyms.c:15 I see:

#include <linux/slab.h>
#include <linux/smp.h>
#define smp_num_cpus 11 <----
#include <linux/module.h>
#include <linux/blkdev.h>

Is that suppose to really be there?

-- 
L1:	khromy		;khromy(at)lnuxlab.ath.cx
