Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVCRQdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVCRQdc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 11:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVCRQdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 11:33:31 -0500
Received: from limicola.its.UU.SE ([130.238.7.33]:38579 "EHLO
	limicola.its.uu.se") by vger.kernel.org with ESMTP id S261694AbVCRQ2u convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 11:28:50 -0500
Message-ID: <423B01A3.8090501@gmail.com>
Date: Fri, 18 Mar 2005 17:28:19 +0100
From: =?ISO-8859-1?Q?Erik_Andr=E9n?= <erik.andren@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Suspend-to-disk woes
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I experienced a pretty nasty problem a couple of days back:

I ran 2.6.11-ck1 and built 2.6.11-ck2. The last thing I did before 
booting the new kernel was to suspend-to-disk the old kernel (something 
I usually do as I'm working on this laptop).
I ran the new kernel a couple of days and decided to boot the old kernel 
to do some performance tests. Imagine my dread as the old kernel instead 
of detecting that the system has booted another kernel just reloads the 
old suspend-to-disk image. The result is that after succesfully 
resuming, my harddrive goes bonkers and starts to work. After a couple 
of minutes the whole kernel hangs. I reboot and try to boot the -ck2 
kernel again only to find that the system complains as it finds missing 
nodes. The reisertools try to rebuild the system unsucessully. The 
--rebuild-tree parameter worked but a lot of files were still missing. 
In the end I had to reinstall the whole system as it went so unstable.

My question is: Why isn't there a check before resuming a 
suspend-to-disk image if the system has booted another kernel since the 
suspend to prevent this kind of hassle?
//Regards Erik Andrén

Please cc me as I'm not on the lkml list yadda yadda

