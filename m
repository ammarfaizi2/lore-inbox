Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277072AbRJDBpF>; Wed, 3 Oct 2001 21:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277073AbRJDBoz>; Wed, 3 Oct 2001 21:44:55 -0400
Received: from embolism.psychosis.com ([216.242.103.100]:30983 "EHLO
	embolism.psychosis.com") by vger.kernel.org with ESMTP
	id <S277072AbRJDBog>; Wed, 3 Oct 2001 21:44:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: Wilson Bilkovich <wilson@dot.dreamhost.com>
Subject: Re: [POT] Linux SAN?
Date: Wed, 3 Oct 2001 21:46:32 -0400
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.21.0110032019480.12116-100000@dozer.dreamhost.com>
In-Reply-To: <Pine.LNX.4.21.0110032019480.12116-100000@dozer.dreamhost.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15oxYi-00015G-00@schizo.psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 October 2001 16:21, you wrote:
> This is fairly off-topic, but would you be willing to describe your
> SAN? I'm getting interested in Linux SAN solutions, and it sounds like
> you've successfully deployed one. If you don't have time, that's fine.

Not much to describe. It's quite straight forward. 3 servers connected to a 
fibre channel hub, connected to a JBOD built using my own product:
	http://www.cinonic.com/

I'm not sharing file systems between host transparently. To do that requires 
an FS like GFS (made by the same guys that handle linux LVM)

All hosts must mirror a single raidtab file for coherency, and you can't use 
things like autoraid starting, as hosts will step on  each others toes. (Use 
md= at cmdline for booting raids) You also want to use devfs in order to keep 
your sanity and access the many devices by actually bus/lun/id and not an 
obsure changing letter. 

If you're not familar with Fibre Channel, it's basically serial SCSI with 
long cable lengths and 126ID's.

FC Drives and HBA's are dirt cheap on ebay right now...have fun and buy soem 
FC2's   : >

Dave

-- 
The time is now 22:19 (Totalitarian)  -  http://www.ccops.org/clock.html
