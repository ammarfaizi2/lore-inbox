Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261264AbSJUIF5>; Mon, 21 Oct 2002 04:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261271AbSJUIF4>; Mon, 21 Oct 2002 04:05:56 -0400
Received: from gateway.ukaea.org.uk ([194.128.63.73]:59200 "EHLO
	fuspcnjc.culham.ukaea.org.uk") by vger.kernel.org with ESMTP
	id <S261264AbSJUIF4>; Mon, 21 Oct 2002 04:05:56 -0400
Message-ID: <3DB3B7A4.C40C1995@ukaea.org.uk>
Date: Mon, 21 Oct 2002 09:15:32 +0100
From: Neil Conway <nconway.list@ukaea.org.uk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4: variable HZ
References: <3DAFF5C9.807BE885@ukaea.org.uk> <1034966657.722.838.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> OK, sure, but why specify a power-of-two HZ?  There is absolutely no
> reason to, at least on x86.

Totally agree.  However, I wasn't restricting it to powers of two.  You
just happened to have mentioned 512 (wrt. RedHat).

> Want 512?  500 will do just as well and has the benefit of (a) being a
> multiple of the previous HZ and (b) evenly dividing into our concept of
> time.

512 ~= 500.  150 !~= 100.  Would someone want to use 150?  Maybe...

Anyway, it's no big deal if you prefer to leave your patch as-is. 
However, if you do, then you need to at least add a comment to the code
and modify the Configure.help to make it clear that only integer
multiples work properly.  In fact, you could just make the HZ Config
value be a "speed-up ratio" which would make various bits of the patch
cleaner.

Neil
