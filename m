Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265114AbSKNRsp>; Thu, 14 Nov 2002 12:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265126AbSKNRso>; Thu, 14 Nov 2002 12:48:44 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:7568 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S265114AbSKNRsn> convert rfc822-to-8bit;
	Thu, 14 Nov 2002 12:48:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Irfan Hamid <irfan_hamid@softhome.net>
Reply-To: irfan_hamid@softhome.net
Organization: Air Weapons Complex
To: chandrasekhar.nagaraj@patni.com, linux-kernel@vger.kernel.org
Subject: Re: Path Name to kdev_t
Date: Thu, 14 Nov 2002 22:50:48 +0000
User-Agent: KMail/1.4.1
References: <000101c28be4$9ff1bf20$e9bba5cc@patni.com>
In-Reply-To: <000101c28be4$9ff1bf20$e9bba5cc@patni.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211142250.48514.irfan_hamid@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in all functions of the driver where you will need the kdev_t (e.g.: the VFS 
layer hooks) you will receive either a struct inode* and/or the struct file* 
of the device file. the i_rdev member of struct inode is defined as the 
kdev_t of the particular device.

hope this helps.

regards,
irfan.

On Thursday 14 November 2002 01:49 pm, chandrasekhar.nagaraj wrote:
> Hi,
>
> In one of the part of my driver module , I have a path name to a device
> file (for eg:- /dev/hda1) .Now if I want to obtain the associated major
> number and minor number i.e. device ID(kdev_t) of this file what would be
> the procedure?
>
> Thanks and Regards
> Chandrasekhar
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

