Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbVHOHuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbVHOHuH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 03:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbVHOHuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 03:50:07 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:28093 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932180AbVHOHuG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 03:50:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SAZ88cfBxrJ07r7OA/n6B2N2eXsfT+HEuKWtNmUN+b4YbPEWuZcOR2k2bOIF3Pj/erKgwCDZ1FG7oXEZr7Zk5CJwdcwtGWhq2a7iLNmefah2ZX+lTxBXEWGZHQosOX8az9+mGp6YWPSUbdSphBO/yCxrrWRPki7Keyvk2CV6+vI=
Message-ID: <76cfec0f0508150050256745a8@mail.gmail.com>
Date: Mon, 15 Aug 2005 13:20:03 +0530
From: Noor <noor.mubeen@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: slab cache size-32 objects growing forever
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed that my system's (kernel 2.4.22) cache memory is fast reducing.
Its normal  value is around 225M always.
its reduced to 175M over about 30 days and still going low.

I notice this unusual behaviour /proc/slabinfo. 

total size-32  objects are very large. 
about 300 objects of some type are being added to size-32
slab every 10min. There is no sign of any reduction.

 size-32(DMA)           0      0     32    0    0    1
 size-32           1979925 1979986    32 17522 17522  

1) What kind of driver/kernel functions need to allocate such size-32 objects.
   ( for eg, if inode is for file inodes, size-32 is for ???)

2) Would it be possible to view the objects (any tool/utility for this)

3) What does this uncontrolled growth imply?
   is someone requesting size-32 objects uncontrollably or
   the Virtual Mem/slab is failing to release the cache.
   or could it be both ?

3) If this is some driver's fault, what kind of flags/code 
   do i grep in driver dir, so that it will help me figure
   a faulty  driver (eg; SLAB_NO_REAP ?) 

Thanks in advance.
Noor
(NB: newbie post)
