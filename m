Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbSKNPYn>; Thu, 14 Nov 2002 10:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbSKNPYm>; Thu, 14 Nov 2002 10:24:42 -0500
Received: from fw-az.mvista.com ([65.200.49.158]:27896 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S264844AbSKNPYm>; Thu, 14 Nov 2002 10:24:42 -0500
Message-ID: <3DD3C1FC.4060409@mvista.com>
Date: Thu, 14 Nov 2002 08:32:12 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: chandrasekhar.nagaraj@patni.com, linux-kernel@vger.kernel.org
Subject: Re: Path Name to kdev_t
References: <000101c28be4$9ff1bf20$e9bba5cc@patni.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You would want to find a struct file * that represents the device (look 
at fs/open.c in the sys_open calls, it shows how to convert a filename 
to a file *) then look at file->f_dentry->d_inode->i_bdev->bd_dev.  This 
is the major/minor dev_t for the device.

Hope this helps.
Thanks
-steve
chandrasekhar.nagaraj wrote:

>Hi,
>
>In one of the part of my driver module , I have a path name to a device file
>(for eg:- /dev/hda1) .Now if I want to obtain the associated major number
>and minor number i.e. device ID(kdev_t) of this file what would be the
>procedure?
>
>Thanks and Regards
>Chandrasekhar
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>
>  
>

