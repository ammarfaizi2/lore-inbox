Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277797AbRJVGBV>; Mon, 22 Oct 2001 02:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277818AbRJVGBL>; Mon, 22 Oct 2001 02:01:11 -0400
Received: from pa92.nowy-targ.sdi.tpnet.pl ([217.97.37.92]:56050 "EHLO
	nt.kegel.com.pl") by vger.kernel.org with ESMTP id <S277797AbRJVGA5>;
	Mon, 22 Oct 2001 02:00:57 -0400
Message-ID: <010801c15abe$ced47240$0100050a@abartoszko>
From: "Albert Bartoszko" <albertb@nt.kegel.com.pl>
To: "Alexander Viro" <viro@math.psu.edu>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0110190845580.22889-100000@weyl.math.psu.edu>
Subject: Re: [PATCH] binfmt_misc.c, kernel-2.4.12
Date: Mon, 22 Oct 2001 08:00:07 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I find bug in  binfmt_misc.c from kernel 2.4.12 source. The read()
syscal
>
> only one?

"Gutta cavat lapidem non vi, sed saepe cadendo"

>
> > return bad value, causes some application SIGSEGV.
>
> Hardly a surprise.  Not everything that passes compiler is valid C.
> Stuff in fs/binfmt_misc.c from Linus' tree isn't.  Pick one from -ac
> + corresponding change in fs/proc/root.c (again, see -ac).  Variant
> in Linus' tree is complete crap.

You are sarcastic.

I do it. And:

# uname -a
Linux xxxx 2.4.12-ac3 #1 Sun Oct 21 13:50:52 CEST 2001 i686 unknown
# insmod binfmt_misc
Using /lib/modules/2.4.12-ac3/kernel/fs/binfmt_misc.o
# echo ':Java:M::\xca\xfe\xba\xbe::/usr/local/bin/javawrapper:'
>/proc/sys/fs/binfmt_misc/register
bash: /proc/sys/fs/binfmt_misc/register: No such file or directory
# lsmod
Module                  Size  Used by
binfmt_misc             5680   1
#rmmod binfmt_misc
binfmt_misc: Device or resource busy                # ?????

Very high C. But this don't work for me.



