Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129249AbRB1UVJ>; Wed, 28 Feb 2001 15:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129270AbRB1UU7>; Wed, 28 Feb 2001 15:20:59 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:56334 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129249AbRB1UUq>;
	Wed, 28 Feb 2001 15:20:46 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102282020.XAA05430@ms2.inr.ac.ru>
Subject: Re: rsync over ssh on 2.4.2 to 2.2.18
To: crosser@average.ORG (Eugene Crosser)
Date: Wed, 28 Feb 2001 23:20:22 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <97hbjr$mbp$1@pccross.average.org> from "Eugene Crosser" at Feb 28, 1 02:15:00 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I've seen hanging rsync over ssh more than once, while sending much data
> from an x86 running Linux (late 2.3.x) to Sparc/Solaris2.5.1

I remember this your report. However, recent news force to suspect
that the reason was in Solaris yet. Actually, if you send tcpdump of
failed session, this question can be answered.


Also REMEMBER!

rsync has __no__ chances to work, if one of sides is Linux-2.2 before 2.2.17
or Solaris of today (sunos-2.5.1 is enough old, probably, it still was right
unlike subsequent kernels). These stacks have conciding set of fatal bugs,
which prevent transmits with closed window.

To use rsync it is necessary to upgrade to >=2.2.17.

Alexey
