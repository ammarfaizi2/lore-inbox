Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272666AbRHaLSm>; Fri, 31 Aug 2001 07:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272667AbRHaLSc>; Fri, 31 Aug 2001 07:18:32 -0400
Received: from t2.redhat.com ([199.183.24.243]:64252 "EHLO
	host140.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S272666AbRHaLS0>; Fri, 31 Aug 2001 07:18:26 -0400
Date: Fri, 31 Aug 2001 12:18:25 +0100 (BST)
From: Bernd Schmidt <bernds@redhat.com>
X-X-Sender: <bernds@host140.cambridge.redhat.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>,
        <linux-kernel@vger.kernel.org>, <ptb@it.uc3m.es>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <Pine.LNX.3.95.1010830171614.18406A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33.0108311216360.27988-100000@host140.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2001, Richard B. Johnson wrote:
> #define MIN(a, b) ((unsigned int)(a) < (unsigned int)(b) ? (a) : (b))

> [root@blackhole /root]# sh -v xxx.sh
> #!/bin/bash
> cat >/tmp/xxx.c <<EOF
> gcc -Wall -Wsign-compare -c -o /dev/null /tmp/xxx.c
> /tmp/xxx.c: In function `main':
> /tmp/xxx.c:9: warning: signed and unsigned type in conditional expression
> rm -f /tmp/xxx.c
> gcc --version
> 2.96
>
> As you can see, the casts are !!!IGNORED!!! in gcc 2.96.

Nope.  The warning refers to the use of a and b in the right-hand side of
the conditional.  You have a type mismatch in the two arms of the
expression.


Bernd

