Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263378AbRFKDhH>; Sun, 10 Jun 2001 23:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263379AbRFKDgr>; Sun, 10 Jun 2001 23:36:47 -0400
Received: from HSE-MTL-ppp72834.qc.sympatico.ca ([64.229.202.135]:19338 "HELO
	oscar.casa.dyndns.org") by vger.kernel.org with SMTP
	id <S263378AbRFKDgq>; Sun, 10 Jun 2001 23:36:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: what is using memory?
Date: Sun, 10 Jun 2001 23:36:42 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-mm@kvack.org
MIME-Version: 1.0
Message-Id: <01061023364200.03146@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been trying to figure out what is using my memory

My box has 

320280K

>From boot I see

   924	kernel
  8224	reserved (initrd ramdisk?)
  1488	hash tables (dentry, inode, mount, buffer, page, tcp)

from lsmod I caculate
  
   876	for loaded modules
  
from proc/slabinfo

 11992	for all slabs

from proc/meminfo

 17140	buffer
123696	cache
 32303	free

leaving unaccounted

123627K 	

This is about 38% of my memory, and only about 46% is pageable
Is it possible to figure out what is using this?

This is with 2.4.6-pre2 with Rik's page_launder_improvements patch, 
lvm beta7 and some reieserfs patches applied, after about 12 hours
of uptime.

TIA,

Ed Tomlinson

