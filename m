Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269591AbRHCUgm>; Fri, 3 Aug 2001 16:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269593AbRHCUgc>; Fri, 3 Aug 2001 16:36:32 -0400
Received: from 66.linscomp.com ([63.141.210.66]:10260 "EHLO exchserv.linsang")
	by vger.kernel.org with ESMTP id <S269591AbRHCUg3>;
	Fri, 3 Aug 2001 16:36:29 -0400
Message-ID: <03f101c11c5b$b53a19d0$6e00a8c0@BBONKOSKI>
From: "Brad Bonkoski" <bbonkoski@xyterra.com>
To: "lkml" <linux-kernel@vger.kernel.org>
Subject: Fw: select(2)
Date: Fri, 3 Aug 2001 13:34:34 -0700
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Brad Bonkoski" <bbonkoski@xyterra.com>
To: <redhat-list@redhat.com>
Sent: Friday, August 03, 2001 10:15 AM
Subject: select(2)


> Hello,
>
> this code:
> fd_set set;
> struct timeval timeout;
> int len_inet;
> int n;
> FD_ZERO(&set);
> timeout.tv_sec = 1L;
> FD_SET(sc_sock,&set);
> n = select(sc_sock+1, &set, NULL, NULL, &timeout);
> if (n == -1)
>

>   perror("select()\n");
>   exit(1);
> }
>
> Works just fine on one machine, i.e. select() does not return a '-1' which
lets it run through the rest of the code.  However, on other machines, it
does not work fine, -1 is always returned by select() with error of: Invalid
arguement
>
> Any ideas on where I could look to fix this problem?  Something in the
syntax of the posted code, or should I be looking at the creation of the
socket?
> TIA.
> Brad
>
>
>
>
>



