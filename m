Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267729AbTBGH7O>; Fri, 7 Feb 2003 02:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267731AbTBGH7O>; Fri, 7 Feb 2003 02:59:14 -0500
Received: from [202.54.64.7] ([202.54.64.7]:21774 "EHLO hclnpd.hclt.co.in")
	by vger.kernel.org with ESMTP id <S267729AbTBGH7N>;
	Fri, 7 Feb 2003 02:59:13 -0500
Message-ID: <3E436997.7040307@npd.hcltech.com>
Date: Fri, 07 Feb 2003 13:38:55 +0530
From: Narsimha Reddy CH <creddy@npd.hcltech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Narsimha Reddy CHALLA <creddy@npd.hcltech.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to install two linux OSes on the same PC
References: <3E418AD0.BC9F9765@npd.hcltech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot for your help. It really worked with disk driud. It 
cleverly managed the name conflicts of lables i.e. for first 
installation the root is "/" and for the second installation the root 
lable is "/1". After editing the /etc/lilo.conf of first installation 
and updating the MBR with /sbin/lilo appropriately, I can boot both of them.

Regards,
- Narsimha


Narsimha Reddy CHALLA wrote:

>Hi  All,
>
>    I want to do two different linux installations rh 7.2 and rh 
>8.0 on the same pc with single hard disk. I installed the rh 7.2 in
>partitions say  /dev/hda5 ( /) ,  /dev/hda6  (/home) ,  /dev/hda7 (
>/usr) ,
>/dev/hda8 ( /tmp),... /dev/hda11  etc. 
>
>   But how can I install the rh 8.0 in partitions say  /dev/hda12
>( as "/" )  ... etc ??  Since the installer won't allow as there
>already exists a  "/"  partition for the rh 7.2 and tries to override
>it with the root partition of rh 8.0. So I tried giving a different
>lable to the root partition of rh 8.0 say /root1 and other partitions
>as /root1/usr, /root1/home, /root1/tmp etc. But here also the installer
>is looking for the partition named "/" and without that the installation
>is not happening. 
>
>
>Please give your suggestions on how to resolve this problem.
>
>
>At present my partition table with single installation (rh 7.2)  is,
>
>[root@creddy-pc root]# fdisk -l
>
>Disk /dev/hda: 255 heads, 63 sectors, 2434 cylinders
>Units = cylinders of 16065 * 512 bytes
>
>   Device Boot    Start       End    Blocks   Id  System
>/dev/hda1   *         1       261   2096451    6  FAT16
>/dev/hda2           262      2434  17454622+   5  Extended
>/dev/hda5           262       522   2096451    6  FAT16
>/dev/hda6           523       653   1052226   83  Linux
>/dev/hda7           654      1175   4192933+  83  Linux
>/dev/hda8          1176      1371   1574338+  83  Linux
>/dev/hda9          1372      1436    522081   82  Linux swap
>/dev/hda10         1437      1501    522081   83  Linux
>/dev/hda11         1502      1566    522081   83  Linux
>[root@creddy-pc root]#
>
>
>TIA,
>- Narsimha Reddy CH
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>


-- 
Narsimha Reddy CH
Storage Area Networking, HCL Technologies
Contact +91-044 2372 8366 ext 1128

http://san.hcltech.com
http://www.hcltech.com



