Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267109AbSKMFGT>; Wed, 13 Nov 2002 00:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267112AbSKMFGS>; Wed, 13 Nov 2002 00:06:18 -0500
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:24077 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S267109AbSKMFGS>; Wed, 13 Nov 2002 00:06:18 -0500
Subject: Re: Distributed Linux
From: "Aneesh Kumar K.V" <aneesh.kumar@digital.com>
To: prasad_s@gdit.iiit.net
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       ssic-linux-devel <ssic-linux-devel@lists.sourceforge.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8-3mdk 
Date: 13 Nov 2002 10:43:24 +0530
Message-Id: <1037164404.16105.12.camel@satan.xko.dec.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As a graduation project i intended to make linux distributed 

This is what exactly  openSSI project does. http://ssic-linux.sf.net 

>The processes would be dynamically migrated from one node to the other
>based on the selections of local process (candidate) and the remote
>node. 

In the case of SSI the process to be migrated is selected  by using
mosix algorithm. If mosix load balancer is   not enabled automatic load
balancing doesn't work. But you can use the migrate() call with "best
node" argument  so that the average load  on the machine is used to
determine which node the process should migrate. 

>The entire task along with its memory map will be migrated on to the
>other system

SSI even support  mmap across cluster. That means you can  even ask a
process  that has done a mmap of file  to migrate to another node. 

>The guest system (where the process originated) would
>however have a pseudo process running on it, which would not take much
>resources but would help in handling various signals/

SSI support cluster wide signaling. That means you can send signal to a
process running on other node( you have cluster wide PID )

It also support cluster wide message queue, DLM , cluster wide device
access and  cluster wide IP. The developers are working on cluster wide
support for  semaphore shared memory  

NOTE:  it support three architectures. x86/IA64/Alpha

-aneesh 



