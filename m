Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316919AbSFKIMQ>; Tue, 11 Jun 2002 04:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316928AbSFKIMP>; Tue, 11 Jun 2002 04:12:15 -0400
Received: from sj-msg-core-4.cisco.com ([171.71.163.10]:28128 "EHLO
	sj-msg-core-4.cisco.com") by vger.kernel.org with ESMTP
	id <S316919AbSFKIMO>; Tue, 11 Jun 2002 04:12:14 -0400
From: "Hua Zhong" <hzhong@cisco.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: dirty buffers and umount/remount
Date: Tue, 11 Jun 2002 01:12:10 -0700
Message-ID: <FEEFKBEFIEBONNKJABKDEEHKDNAA.hzhong@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
In-Reply-To: <FEEFKBEFIEBONNKJABKDGEHIDNAA.hzhong@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am wondering if 3) is necessary or not. When the filesystem is remounted
> from rw to ro, are all dirty buffers related to it flushed to disk? How
> about umount?
>
> The last related question: is the kdev field in the buffer head
> the physical
> block device (i.e., /dev/hda) or the logical block device (i.e.,
> /dev/hda7)?

auh..it must be the logical device which is passed as the mount point..

I also checked the mount/umount code, and didn't find any part does the
flush.
So I guess data can still be lost after an unmount?

> Thanks a lot.
>
> Hua
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

