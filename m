Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318032AbSGLWOF>; Fri, 12 Jul 2002 18:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318033AbSGLWOE>; Fri, 12 Jul 2002 18:14:04 -0400
Received: from pizda.ninka.net ([216.101.162.242]:36524 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318031AbSGLWMZ>;
	Fri, 12 Jul 2002 18:12:25 -0400
Date: Fri, 12 Jul 2002 15:06:07 -0700 (PDT)
Message-Id: <20020712.150607.35506145.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: matts@ksu.edu, shemminger@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 64 bit netdev stats counter
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1026516053.9958.33.camel@irongate.swansea.linux.org.uk>
References: <Pine.GSO.4.33L.0207121628100.19313-100000@unix2.cc.ksu.edu>
	<20020712.145835.91443486.davem@redhat.com>
	<1026516053.9958.33.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 13 Jul 2002 00:20:53 +0100

   gcc will output
   
   		increment low 32bit
   		if zero
   			increment high
   
   Which means we can rapidly get 2^32 out of sync
   
True and this equals the "fix" suggested C code involving
two 32-bit counters that the original author posted :-)

So this makes both cases equally wrong.
