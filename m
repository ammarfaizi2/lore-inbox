Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276751AbRJ3X7Z>; Tue, 30 Oct 2001 18:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276759AbRJ3X7P>; Tue, 30 Oct 2001 18:59:15 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:40755 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S276751AbRJ3X7E>; Tue, 30 Oct 2001 18:59:04 -0500
Date: Tue, 30 Oct 2001 18:59:43 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200110302359.f9UNxht09639@devserv.devel.redhat.com>
To: rjk@greenend.org.uk, linux-kernel@vger.kernel.org
Subject: Re: problem with ide-scsi and IDE tape drive
In-Reply-To: <mailman.1004484541.12716.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1004484541.12716.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I originally found this under 2.2.19, and upgraded to 2.4.13 to see if
> the problem was still there when running more recent code.  It is.

>     mt -f $TAPE rewind
>     echo "tape 1" | dd conv=sync of=$TAPE bs=$hsize count=1
> 
>     for x in 1 2 3; do
>       mt -f $TAPE rewind
>       dd if=$TAPE of=/dev/null bs=$hsize
>       date
>       tar -c -b 20 -f $TAPE /boot
>     done

Try "mt fsf" instead dd, see if that helps.

-- Pete
