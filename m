Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267050AbTAZXLb>; Sun, 26 Jan 2003 18:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267065AbTAZXLb>; Sun, 26 Jan 2003 18:11:31 -0500
Received: from [213.86.99.237] ([213.86.99.237]:18142 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S267050AbTAZXLa>; Sun, 26 Jan 2003 18:11:30 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20030127000740.GJ394@kugai> 
References: <20030127000740.GJ394@kugai>  <20030126231232.GE394@kugai> <20030126215714.GA394@kugai> <Pine.LNX.4.44.0301261524570.15900-100000@chaos.physics.uiowa.edu> <30633.1043621749@passion.cambridge.redhat.com> 
To: Christian Zander <zander@minion.de>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 26 Jan 2003 23:16:11 +0000
Message-ID: <31172.1043622971@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


zander@minion.de said:
>  I apologize if I have argued based on false assumptions; is it true
> then that a Makefile written for use with Linux 2.5 kbuild will work
> unchanged with any Linux 2.2/2.5 kernel (w/ custom CFLAGS, ...)?

There are some differences, but nothing insurmountable.

For <=2.4 you have to include Rules.make at the end of your own Makefile,
and for 2.5 that file doesn't exist any more. 

For older kernels you must set O_TARGET, for 2.5 I think the mere act of
setting it causes the build to break -- that one is gratuitously making it
harder to make external modules which compile in both and I've complained
about it before.

Per-file CFLAGS must have a full path specified now in 2.5, whereas in 2.4 
and earlier it was just 'CFLAGS_filename.o'.

--
dwmw2


