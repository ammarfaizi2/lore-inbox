Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270219AbTHOQoY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267952AbTHOQl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:41:56 -0400
Received: from fw1.masirv.com ([65.205.206.2]:64404 "EHLO NEWMAN.masirv.com")
	by vger.kernel.org with ESMTP id S270496AbTHOQkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:40:12 -0400
Message-ID: <1060912337.31243.49.camel@huykhoi>
From: Anthony Truong <Anthony.Truong@mascorp.com>
To: John Newbie <john_r_newbie@hotmail.com>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Subject: Re: ide drives performance issues, maybe related with buffer cach
	e.
Date: Thu, 14 Aug 2003 18:52:16 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-15 at 23:39, John Newbie wrote:

> > So question is : why when i am copying file from one HD to another
(for
> > simplicity from /hda to /hdb)
> > the speed fall down ? Starting from about 27-30 MB/s (drives are in 
>UDMA-4,
> > hdparm -X68) it drops
> > down to 11-12 MB/s after 4-5s. In *indows transfer rate is almost 
>constant
> > and about 20-22 MB/s (same hardware). Why the h#ll we suck?
> > I feel that it's due to buffer cache, because when you use sync
(while
> > copying) transfer rate is so small or even 0.
> > Drives are tuned with hdparm to highest transfer rates, readahead, 
>multiple
> > sector count (hdparm
> > for details).
> > Tried different filesystems, from classic ext2/3 to modern
xfs/reiserfs. 
>The
> > same results.
> > Pure kernel from kernel.org (2.4.{19,20,21}), vendors kernels - all
the

>How do you copy files? cp? dd? Midnight Commander? ;)
>Does it happen with SCSI?
>--
>vda

I've used cp & Midnight Commander (mc). Also when someone uploads big
file 
on server through
samba, speed sometimes fall down to zero.

Have no idea about scsi, drives are IDE.

Hello,
Let's see if we can eliminate this HW constraint:
Do you have the 2 HDs at the same IDE port (primary or secondary) or at
different IDE ports?
It might be related to the fact that IDE driver can't send 2
simultaneous cmds to 2 different drives if they are attached to the same
IDE port.
This is a simple point, but I hope we don't overlook it when making the
comparison between Linux and *dows. :-)

Regards,
Anthony Dominic Truong.




Disclaimer: The information contained in this transmission, including any
attachments, may contain confidential information of Matsushita Avionics
Systems Corporation.  This transmission is intended only for the use of the
addressee(s) listed above.  Unauthorized review, dissemination or other use
of the information contained in this transmission is strictly prohibited.
If you have received this transmission in error or have reason to believe
you are not authorized to receive it, please notify the sender by return
email and promptly delete the transmission.


