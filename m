Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130188AbQLCHtl>; Sun, 3 Dec 2000 02:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130688AbQLCHtb>; Sun, 3 Dec 2000 02:49:31 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:46096 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130643AbQLCHtX>; Sun, 3 Dec 2000 02:49:23 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: /dev/random probs in 2.4test(12-pre3)
Date: 2 Dec 2000 23:17:51 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <90cs2v$6u6$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.3.96.1001202115753.27887T-100000@mandrakesoft.mandrakesoft.com> <Pine.LNX.4.21.0012022229580.11907-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.21.0012022229580.11907-100000@server.serve.me.nl>
By author:    Igmar Palsenberg <maillist@chello.nl>
In newsgroup: linux.dev.kernel
> 
> > For a blocking fd, read(2) has always blocked until some data is
> > available.  There has never been a guarantee, for any driver, that
> > a read(2) will return the full amount of bytes requested.
> 
> I know. Still leaves lot's of people that assume that reading /dev/random
> will return data, or will block.
> 
> I've seen lots of programs that will assume that if we request x bytes
> from /dev/random it will return x bytes.
> 

Again, that's wrong even when you replace /dev/random with something
else.  After all, you could be getting EINTR at any time, too, or get
interrupted by a signal in the middle (in which case you'd get a short
read.)

SUCH CODE IS BROKEN.  PERIOD.  FULL STOP.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
