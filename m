Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBURNA>; Wed, 21 Feb 2001 12:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129184AbRBURMu>; Wed, 21 Feb 2001 12:12:50 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:55729 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S129051AbRBURMi>; Wed, 21 Feb 2001 12:12:38 -0500
Date: Wed, 21 Feb 2001 18:12:34 +0100
From: Christoph Baumann <baumann@kip.uni-heidelberg.de>
To: linux-kernel@vger.kernel.org
Subject: Problem with DMA buffer (in 2.2.15)
Message-ID: <20010221181234.D4878@kip.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have the following problem.
A user process wants to talk to a PCI board via DMA. The first step I did was
to resolv the physical addresses of the data in user space. This works fine
when writing to the device. But when reading the buffer isn't allocated
and the physical addresses are resolved to zero. I fixed this with initializing
the buffer. My question is: Is there a faster method to get the kernel to
map all the virtual addresses at once and not each by each? This would
increase the performance enormously (from 33MB/s to [hopefully] 100MB/s).

Christoph 

-- 
**********************************************************
* Christoph Baumann                                      *
* Kirchhoff-Institut für Physik - Uni Heidelberg         *
* Mail: baumann@kip.uni-heidelberg.de                    *
* Phone: ++49-6221-54-4329                               *
**********************************************************

