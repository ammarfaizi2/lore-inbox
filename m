Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133063AbRBRRZM>; Sun, 18 Feb 2001 12:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133084AbRBRRZC>; Sun, 18 Feb 2001 12:25:02 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:1041 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S133063AbRBRRYu>;
	Sun, 18 Feb 2001 12:24:50 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102181724.UAA24231@ms2.inr.ac.ru>
Subject: Re: SO_SNDTIMEO: 2.4 kernel bugs
To: chris@scary.beasts.org (Chris Evans)
Date: Sun, 18 Feb 2001 20:24:35 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <Pine.LNX.4.30.0102172239570.24119-100000@ferret.lmh.ox.ac.uk> from "Chris Evans" at Feb 17, 1 10:46:19 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Unfortunately, I discovered a bug with SO_SNDTIMEO/sendfile():

None of the options apply to sendfile(). It is not socket level
operation. You have to use alarm for it.

BTW, if you have enough fast network, you probably can observe
that sendfile() is even not interrupted by signals. 8) But this
is possible to fix at least. BTW the same fix will repair SO_*TIMEO
partially, i.e. it will timeout after n*timeo, where n is an arbitrary
number not exceeding size/sndbuf.

Alexey
