Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129550AbQKOVww>; Wed, 15 Nov 2000 16:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129932AbQKOVwn>; Wed, 15 Nov 2000 16:52:43 -0500
Received: from pec-149-207.tnt6.h2.uunet.de ([149.225.149.207]:772 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id <S129550AbQKOVw1>; Wed, 15 Nov 2000 16:52:27 -0500
Date: Wed, 15 Nov 2000 21:21:10 +0000
From: Thorsten Kranzkowski <th@Marvin.DL8BCU.ampr.org>
To: "George R. Kasica" <georgek@netwrx1.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Question on SCSI Tape Changer Status
Message-ID: <20001115212110.A289@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@gmx.net
Mail-Followup-To: "George R. Kasica" <georgek@netwrx1.com>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <cpc51to6bgkkg4dk9vn786vbmd4i6u9ij0@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <cpc51to6bgkkg4dk9vn786vbmd4i6u9ij0@4ax.com>; from georgek@netwrx1.com on Wed, Nov 15, 2000 at 10:32:19AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2000 at 10:32:19AM -0600, George R. Kasica wrote:
> I've got an HP 4mm DAT Autochanger here (Scsi detection shown below
> >from boot)...what I'm wondering is this: Is there a way to tell WHICH
> ONE of the 6 tapes is in the actual tape drive from the OS? And if so,
> a way to make it load a specific tape (1-6 or maybe 0-5 I'm not sure

There's a kernel patch along with userspace ustils at 
http://www.in-berlin.de/User/kraxel/linux.html (scsi-changer)
that exactly does what you want. I use it with 2.2.18pre_something at 
work but a 2.4 patch is also provided. It works great with our DLT-loader.

I wonder why this still isn't in the mainline kernel though....


> Oct 26 22:20:27 eagle kernel:   Vendor: HP        Model: C1553A
> Rev:NS01
> Oct 26 22:20:27 eagle kernel:   Type:   Medium Changer
                                          ^^^^^^^^^^^^^^
The patch makes this /dev/sch0

> ANSI SCSI revision: 02
> Oct 26 22:20:27 eagle kernel: Detected scsi generic sg2 at scsi0,
> channel 0, id 3, lun 1

Bye,
Thorsten

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@gmx.net                        |
| Mobile: ++49 170 1876134       Snail: Niemannsweg 30, 49201 Dissen, Germany |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
