Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbUFNKpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUFNKpT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 06:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbUFNKpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 06:45:19 -0400
Received: from bay14-f22.bay14.hotmail.com ([64.4.49.22]:61714 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262356AbUFNKpO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 06:45:14 -0400
X-Originating-IP: [212.143.127.195]
X-Originating-Email: [qwejohn@hotmail.com]
From: "John Que" <qwejohn@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: insmod of ov511 failes
Date: Mon, 14 Jun 2004 13:45:13 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY14-F22zmWecm9t0C00089a46@hotmail.com>
X-OriginalArrivalTime: 14 Jun 2004 10:45:13.0454 (UTC) FILETIME=[AC1F08E0:01C451FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have tried to perform build modules from the kernel tree ;
Now , when I try to insmod the module (it's a video driver,ov511.o), I get
many unresolved symbol errors like  the follwing error of

unresolved symbol video_register_device_Re376151777

I have a backup old version of the module binary (ov511.o); when I
insert it I do succeed.
I tried
cat /proc/ksyms |grep video_register_device

de975b90 video_register_device_R31b9699b        [videodev]

I also tried
nm -a ov511.o  and I got:
U video_register_device_R31b9699b

but  the same nm operation on the new one gives a different result:
nm -a ov511.o  and I got:
U video_register_device_Re3761517

from where are the differences ? what is the meaning of the
differences in the "R" (relocation) extension?

I assume that if I will build the bzImage and install it I will succeed to
insmod the new module;

But I am curious - does this problem have a workaround?

Could this problem be cause because I also installed 2.6.0 kernel on the 
same machine?
regards,
John

_________________________________________________________________
Add photos to your e-mail with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail

