Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbTH3Xiz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 19:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTH3Xiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 19:38:55 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:27064 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262337AbTH3Xij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 19:38:39 -0400
Subject: Re: [PATCH] check_gcc for i386
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0308301957440.20117-100000@logos.cnet>
References: <Pine.LNX.4.44.0308301957440.20117-100000@logos.cnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062286661.31332.8.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sun, 31 Aug 2003 00:37:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-08-30 at 23:58, Marcelo Tosatti wrote:
> >  ifdef CONFIG_MPENTIUM4
> > -CFLAGS += -march=i686
> > +CFLAGS += $(call check_gcc,-march=pentium4,-march=i686)
> >  endif
> >  
> >  ifdef CONFIG_MK6
> 
> OK, I forgot what that does. Can you please explain in detail what 
> check_gcc does. 

Tries to use gcc with the options given and if not falls back to the
second set suggested. So it'll try -march=pentium4 (new gcc) and 
fall back to -march=i686

