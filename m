Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130770AbQLLUZC>; Tue, 12 Dec 2000 15:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131123AbQLLUYv>; Tue, 12 Dec 2000 15:24:51 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:29452 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S130770AbQLLUYk>;
	Tue, 12 Dec 2000 15:24:40 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200012121953.WAA29123@ms2.inr.ac.ru>
Subject: Re: Bad behavior of recv on already closed sockets.
To: dyp@perchine.com (Denis Perchine)
Date: Tue, 12 Dec 2000 22:53:58 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <0012121838460H.18833@dyp.perchine.com> from "Denis Perchine" at Dec 12, 0 06:38:46 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > It would be better to understand the issue f.e. trying to restore
> > the history of this descriptor.
> 
> How to do this? I mean what should I do to provide you with more information?

I do not know exactly. It depends on curcumstances, frequency 
of the stalls and... your luck. 8)

Usually in such cases I ask to start from gathering single huge
binary tcpdump (tcpdump -i lo -b ip -w big.dump port 3994)
until the problem happens. Then you cut of it the problematic session
with tcpdump again (tcpdump -n -vvv -r big.dump port 2994 and port 5432).
Then we will have at least picture at network side.

If after this we will not understand what happened then tracing
at application level. It is more complicated and depends mostly
on particular application. strace is too promiscuous as rule
and does not work well with intensively forking applications.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
