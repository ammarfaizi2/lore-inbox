Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267013AbTBLKqI>; Wed, 12 Feb 2003 05:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267022AbTBLKqH>; Wed, 12 Feb 2003 05:46:07 -0500
Received: from daimi.au.dk ([130.225.16.1]:22159 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S267013AbTBLKqH>;
	Wed, 12 Feb 2003 05:46:07 -0500
Message-ID: <3E4A2824.5D915F9F@daimi.au.dk>
Date: Wed, 12 Feb 2003 11:55:32 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Olaf Titz <olaf@bigred.inka.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Setjmp/Longjmp in the kernel?
References: <20030209221044.GA8761@morningstar.nowhere.lie> <1044882041.418.1.camel@irongate.swansea.linux.org.uk> <E18iMLx-00020k-00@bigred.inka.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Titz wrote:
> 
> Not that this matters any bit, but the proper order is of course
>         alloc this
>         alloc that
>         _foo_func()
>         free that
>         free this
> 
> even if only for aesthetical reasons :-)
> 
> (with locks, it does matter...)

For locks it is only when you lock the order matters, not when
you unlock. For allocations there is of course the possibility
that the first allocation suceeds and the second fails, which
you must handle in some way.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
