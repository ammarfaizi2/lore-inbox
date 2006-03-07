Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751568AbWCGSy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbWCGSy1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 13:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbWCGSy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 13:54:27 -0500
Received: from cmsout03.mbox.net ([165.212.64.33]:35463 "EHLO
	cmsout03.mbox.net") by vger.kernel.org with ESMTP id S1751172AbWCGSy0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 13:54:26 -0500
X-USANET-Source: 165.212.11.129  IN   lion@3tera.com uadvg129.cms.usa.net
X-USANET-MsgId: XID930kcgs3Z7704X03
X-USANET-Auth: 82.81.211.211   AUTH lkalev@usa.net [192.168.0.101]
Message-ID: <440DD6D7.9020206@3tera.com>
Date: Tue, 07 Mar 2006 10:54:15 -0800
From: Leonid Kalev <lion@3tera.com>
Reply-To: lion@3tera.com
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sumit Narayan <talk2sumit@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error while copying file on a new filesystem
References: <1458d9610603062122x4d5687efw99fca51944c56202@mail.gmail.com>
In-Reply-To: <1458d9610603062122x4d5687efw99fca51944c56202@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Z-USANET-MsgId: XID967kcgs3y0103X29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sumit Narayan wrote:

>Hi,
>
>I am involved in development of a new file system. I can successfully
>write/read on the filesystem partition. But when I copy or move a
>file, I get this error:
>
>[root@sumit /mnt/newfs]# mv /root/1 .
>mv: writing `/mnt/newfs/1': No space left on device
>
>And although I get this error, the file is successfully copied to the
>directory and I can read the file properly after that.
>
>Can somebody please explain why this is happening. 'df' shows that
>there are free available inodes/disk space. I am using device
>virtualization to provide a single mount point for multiple devices.
>
>  
>
I would venture to guess that your filesystem handler for 'write' 
returned 0 as the number of bytes written, even though it wrote all the 
data successfully (as you say, you can read it afterwards).

regards,

Leo

