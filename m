Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288980AbSBIPtL>; Sat, 9 Feb 2002 10:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288995AbSBIPtB>; Sat, 9 Feb 2002 10:49:01 -0500
Received: from pc1-camc5-0-cust78.cam.cable.ntl.com ([80.4.0.78]:46559 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S288980AbSBIPso>;
	Sat, 9 Feb 2002 10:48:44 -0500
Message-Id: <m16ZZj7-000OVeC@amadeus.home.nl>
Date: Sat, 9 Feb 2002 15:47:45 +0000 (GMT)
From: arjan@fenrus.demon.nl
To: kraxel@bytesex.org (Gerd Knorr)
Subject: Re: [PATCH] __free_pages_ok oops
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020209151414.A18937@bytesex.org>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020209151414.A18937@bytesex.org> you wrote:

> vfree() isn't allowed?  I know vmalloc() isn't because it might sleep
> while waiting for the VM getting a few free pages.  Why vfree isn't
> allowed?  I can't see why freeing ressources is a problem ...

vfree() needs the semaphore vmalloc also uses. It's a semaphore because
vmalloc sleeps....

vmalloc/vfree are intended for slow-path only so it ought to not be a
problem....
