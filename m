Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S160431AbPFNJJs>; Mon, 14 Jun 1999 05:09:48 -0400
Received: by vger.rutgers.edu id <S160418AbPFNJJ3>; Mon, 14 Jun 1999 05:09:29 -0400
Received: from mentolat-e0.core.genedata.com ([157.161.173.16]:16004 "EHLO mail.core.genedata.com") by vger.rutgers.edu with ESMTP id <S160404AbPFNJIr>; Mon, 14 Jun 1999 05:08:47 -0400
Date: Mon, 14 Jun 1999 11:08:38 +0200
From: Matthew Wilcox <Matthew.Wilcox@genedata.com>
To: Andries.Brouwer@cwi.nl
Cc: ralf@uni-koblenz.de, alan@lxorguk.ukuu.org.uk, bishop@sekure.org, daniel.kobras@student.uni-tuebingen.de, drepper@cygnus.com, linux-kernel@vger.rutgers.edu, mingo@chiara.csoma.elte.hu
Subject: Re: size of pid_t (was: Re: NR_TASKS as config option)
Message-ID: <19990614110838.J1415@mencheca.ch.genedata.com>
References: <UTC199906131847.UAA26622.aeb@eland.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <UTC199906131847.UAA26622.aeb@eland.cwi.nl>; from Andries.Brouwer@cwi.nl on Sun, Jun 13, 1999 at 08:47:08PM +0200
Sender: owner-linux-kernel@vger.rutgers.edu

On Sun, Jun 13, 1999 at 08:47:08PM +0200, Andries.Brouwer@cwi.nl wrote:
>         #define PID_MAX 0x8000
> in <linux/tasks.h>, and at first sight not much goes wrong
> if we pick some larger number for PID_MAX, like 0x7fffffff.
> (There are some comparisons around, so for simplicity we should
> keep PID_MAX positive.)

Also, a negative pid_t is used to represent the process group in some
calls, notably the SIOCSPGRP and SIOCGPGRP ioctls.

-- 
Matthew Wilcox <willy@bofh.ai>
"Windows and MacOS are products, contrived by engineers in the service of
specific companies. Unix, by contrast, is not so much a product as it is a
painstakingly compiled oral history of the hacker subculture." - N Stephenson

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
