Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161869AbWKPGSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161869AbWKPGSB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 01:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031109AbWKPGSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 01:18:01 -0500
Received: from wx-out-0506.google.com ([66.249.82.234]:35752 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1031076AbWKPGSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 01:18:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WmKK7cLrjlJkK/WHsA0Udn7q9hggluBP74PvakIGrhW/AIX3XW8I7I1fHZWQmg8mKBnaNQj/cPWm3SO+Kiy24x07WeOB/dX1XZ46lm+CRxmeG1gkubD3k3+FcmBkw9yNAp3WE4iwoazb3NxevQc9TjNxGcWvTxnM/aDOqESFjM0=
Message-ID: <1e62d1370611152217y34211ae6i5e3231058c52c650@mail.gmail.com>
Date: Thu, 16 Nov 2006 11:17:59 +0500
From: "Fawad Lateef" <fawadlateef@gmail.com>
To: "Chuanwen Wu" <wcw8410@gmail.com>
Subject: Re: How to change my fs's magic number?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7797aa370611041901k5bc82055q9477521b0f2eca34@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <7797aa370611041901k5bc82055q9477521b0f2eca34@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 11/5/06, Chuanwen Wu <wcw8410@gmail.com> wrote:
> Hi,everybody!
>
> I am learning how to add my file system.
> Now ,i have add my fs called "myext2" with the magic number 0x6666
> (" #define MYEXT2_SUPER_MAGIC      0x6666" in the file
> include/linux/myext2_fs.h)to the kernel .
> Myext2 is similar with ext2 but the name.
> And i compiled kernel successfully.
> And then i created my "myfs" in the type myext2
>
> #dd if=/dev/zero of=myfs bs=1M count=1
> #mkfs.ext2 myfs
>
> The problem is after "#mkfs.ext2 myfs" ,how i can change myfs's magic
> number to 0x6666 but not 0xEF53 which is used by ext2?
>

I am assuming that you changed EXT2 filesystem in a way that only name
of the filesystem and magic number is changed by you, now when you are
creating filesystem through mkfs.ext2 it is writting the magic number
of EXT2 in your file/drive so you must change mkfs.ext2 utility too
means it should write your specified magic number on file/drive during
filesystem creation and you will be able to mount it. You can get the
source of mkfs and other ext2 related utilties from e2fsprogs (just
google for it).

-- 
Fawad Lateef
