Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266827AbRIKPB0>; Tue, 11 Sep 2001 11:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272501AbRIKPBS>; Tue, 11 Sep 2001 11:01:18 -0400
Received: from smtp.mediascape.net ([212.105.192.20]:15886 "EHLO
	smtp.mediascape.net") by vger.kernel.org with ESMTP
	id <S272467AbRIKPBI>; Tue, 11 Sep 2001 11:01:08 -0400
Message-ID: <3B9E270C.95C478B7@mediascape.de>
Date: Tue, 11 Sep 2001 17:00:28 +0200
From: Olaf Zaplinski <o.zaplinski@mediascape.de>
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.9-ac10 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: AIC + RAID1 error? (was: Re: aic7xxx errors)
In-Reply-To: <200109072337.f87NbPY92715@aslan.scsiguy.com> <3B9CC525.7E26ABC2@mediascape.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Zaplinski wrote:
[...]
> But how can I help to reproduce the error? Of course I could break the
> mirror, compile the driver into the kernel (non-module) and do some stress
> test on the SCSI drive. But it's not so good when I drive this machine into
> a hang too often.

Well, I tried that actually:

- insmod'ed the new driver ('verbose', 'tcq=32')
- broke mirror
- mke2fs /dev/sda1
- tar'ed / to /mnt (which was the mounted sda1)

=> no errors

So it has to do with the RAID code, I think.

Olaf
