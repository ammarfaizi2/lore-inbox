Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133090AbRDRLpR>; Wed, 18 Apr 2001 07:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133091AbRDRLpM>; Wed, 18 Apr 2001 07:45:12 -0400
Received: from upsn13.u-psud.fr ([193.55.10.113]:59618 "EHLO upsn13.u-psud.fr")
	by vger.kernel.org with ESMTP id <S133090AbRDRLop>;
	Wed, 18 Apr 2001 07:44:45 -0400
Message-ID: <3ADD7E03.F8ED7F83@fleming.u-psud.fr>
Date: Wed, 18 Apr 2001 13:44:04 +0200
From: Jaquemet Loic <jal@fleming.u-psud.fr>
X-Mailer: Mozilla 4.75 [fr] (X11; U; Linux 2.4.3-ac9 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: VFS problem
In-Reply-To: <3ADD6EE6.5EB89FCF@fleming.u-psud.fr>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaquemet Loic a écrit :

> Sorry if this problem has already been disscussed.
>
> I run an linux box with a HD 30Go/reiserfs .
> I tried several 2.4 kernel ( 2.4.2 , 2.4.3 , 2.4.4-pre3 , 2.4.3-ac7)
> After a random time I've got a fs problem which lead to :
> -first a segfault of a process which reads/writes on the partition
> ex:
> [jal@skippy prog]$ ./configure
> ....
> ln -s dialects/linux/machine.h machine.h
> Erreur de segmentation ( SEGFAULT )
>
> -and then the partition freeze .Any attempt to read/write on it leads to
>
> put the process in a D state and makes it unkillable.
> [/var/log/kernel]
> Apr 18 11:35:06 skippy kernel: VFS: Disk change detected on device
> ide0(3,64)
> ...[Random time after]
> Apr 18 11:55:26 skippy kernel: Unable to handle kernel NULL pointer
> dereference at virtual address 00000000
> Apr 18 11:55:26 skippy kernel:  printing eip:
> Apr 18 11:55:26 skippy kernel: c019671a
> Apr 18 11:55:26 skippy kernel: pgd entry c3f46000: 0000000000000000
> Apr 18 11:55:26 skippy kernel: pmd entry c3f46000: 0000000000000000
> Apr 18 11:55:26 skippy kernel: ... pmd not present!
> Apr 18 11:55:26 skippy kernel: Oops: 0000
> Apr 18 11:55:26 skippy kernel: CPU:    0
>
> I will try with ac9 but I'm not really sure of the result..
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Rectification : the VFS disk change is a normal event , and has no
interaction with the kernel NULL pointer.
So , does someone has a clue ?

