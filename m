Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262591AbSI0THY>; Fri, 27 Sep 2002 15:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262596AbSI0THY>; Fri, 27 Sep 2002 15:07:24 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:29175 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262591AbSI0TGn>; Fri, 27 Sep 2002 15:06:43 -0400
Subject: Re: [patch] 'virtual => physical page mapping
	cache',vcache-2.5.38-B8
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Ingo Molnar <mingo@elte.hu>, Chris Wedgwood <cw@f00f.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <3D94A4D9.D458D453@digeo.com>
References: <Pine.LNX.4.44.0209271952540.17034-100000@localhost.localdomain>
	<1033149675.16758.8.camel@irongate.swansea.linux.org.uk> 
	<3D94A4D9.D458D453@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Sep 2002 20:16:26 +0100
Message-Id: <1033154186.16726.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-27 at 19:35, Andrew Morton wrote:
> O_DIRECT writes operate under i_sem, which provides exclusion
> from trucate.  Do you know something which I don't??

So it does, hidden away in generic_file_write rather than the lower
layers. Interesting. So now I have a new question to resolve, which is
why doing O_DIRECT and truncate together corrupted my disk when I tried
it trying to break stuff


