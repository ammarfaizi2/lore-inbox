Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268124AbTBMWgd>; Thu, 13 Feb 2003 17:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268126AbTBMWgc>; Thu, 13 Feb 2003 17:36:32 -0500
Received: from quechua.inka.de ([193.197.184.2]:50304 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S268124AbTBMWgC>;
	Thu, 13 Feb 2003 17:36:02 -0500
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Accessing the same disk via multiple channels
In-Reply-To: <20030213194917.GA8479@quadpro.stupendous.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.14-20020917 ("Chop Suey!") (UNIX) (Linux/2.4.18-xfs (i686))
Message-Id: <E18jS75-0007na-00@calista.inka.de>
Date: Thu, 13 Feb 2003 23:45:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030213194917.GA8479@quadpro.stupendous.org> you wrote:
> Each server is equipped with 2 FibreChannel cards. The SAN is
> configured to present the same disk (which is in fact a virtual
> Symmetrix device) over two channels. This means the host sees
> two physical devices (as far as that host's concerned) which is
> in fact really only one device. In linux terms: /dev/sda and /dev/sdc
> are exactly the same disks, but the (standard) OS doesn't know this.
...
> How does linux as it is now handle the situation of one physical device
> presented via multiple paths (without extra software)?

You can use the multipath option to md which can do that.

Basically there are two options, a failover and a load balancing option. The
problem with failover is, to detect the actual failure reliable, toe problem
with load balancing is, that not all san configurations allow this.

http://www-124.ibm.com/storageio/multipath/md-multipath/index.php

this is at least in 2.4.20-xfs

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
