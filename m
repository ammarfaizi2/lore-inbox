Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280201AbRJaNX0>; Wed, 31 Oct 2001 08:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280235AbRJaNXR>; Wed, 31 Oct 2001 08:23:17 -0500
Received: from mail006.mail.bellsouth.net ([205.152.58.26]:51643 "EHLO
	imf06bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280232AbRJaNXN>; Wed, 31 Oct 2001 08:23:13 -0500
Message-ID: <3BDFFB64.CE5F73D9@mandrakesoft.com>
Date: Wed, 31 Oct 2001 08:23:48 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pre6 weird ps output
In-Reply-To: <3BDFF758.C5CC5A61@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> [jgarzik@brutus rpm]$ ps xf
>   PID TTY      STAT   TIME COMMAND
> 16013 pts/1    S      0:00 -bash
> 32105 pts/1    R      0:00 ps xf
> 15858 pts/0    S      0:00 -bash
> 15889 pts/0    S      0:02 /bin/sh /usr/bin/rpm-rebuilder
> 30660 /tmp/rpm/other_clisp-2.27-1mdk.src.rpm.log S   0:00  \_
> /usr/lib/rpm/rpmb
> 30670 /tmp/rpm/other_clisp-2.27-1mdk.src.rpm.log S   0:00      \_
> /bin/sh -e /tm
> 30671 /tmp/rpm/other_clisp-2.27-1mdk.src.rpm.log S   0:00          \_
> /bin/sh ./
> 31942 /tmp/rpm/other_clisp-2.27-1mdk.src.rpm.log S   0:00

Further clue:  kill ssh session and log back in later, and ps output
[from a different pty] is normal.

> [jgarzik@brutus jgarzik]$ ps xf
>   PID TTY      STAT   TIME COMMAND
> 15858 pts/0    S      0:00 -bash
> 15889 pts/0    S      0:02 /bin/sh /usr/bin/rpm-rebuilder
> 21855 pts/0    S      0:00  \_ /usr/lib/rpm/rpmb -bb --clean --rmspec --rmsource
> 21863 pts/0    S      0:00      \_ /bin/sh -e /tmp/rpm/tmp/rpm-tmp.70455
> 25822 pts/0    S      0:00          \_ make
> 25823 pts/0    S      0:00              \_ make all-recursive
> 25824 pts/0    S      0:00                  \_ /bin/sh -c set fnord w; amf=$2;  
> 25840 pts/0    S      0:00                      \_ /bin/sh -c set fnord w; amf=$
> 25841 pts/0    S      0:00                          \_ make all
> 25842 pts/0    S      0:00                              \_ /bin/sh -c set fnord 
>  2530 pts/0    S      0:00                                  \_ /bin/sh -c set fn
>  2531 pts/0    S      0:00                                      \_ make all
>  3802 pts/0    S      0:00                                          \_ /bin/sh .
>  4041 pts/0    S      0:00                                              \_ gcc -
>  4043 pts/0    R      0:01                                                  \_ /
>  4044 pts/0    S      0:00                                                  \_ a
>  2801 pts/2    S      0:00 -bash
>  2777 pts/1    S      0:00 -bash
>  4045 pts/1    R      0:00 ps xf


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

