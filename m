Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268352AbSIRUu6>; Wed, 18 Sep 2002 16:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268356AbSIRUu6>; Wed, 18 Sep 2002 16:50:58 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49037 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268352AbSIRUu6>;
	Wed, 18 Sep 2002 16:50:58 -0400
Date: Wed, 18 Sep 2002 13:46:30 -0700 (PDT)
Message-Id: <20020918.134630.127509858.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: ebiederm@xmission.com, hadi@cyberus.ca, akpm@digeo.com,
       manfred@colorfullife.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Info: NAPI performance at "low" loads
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1032381789.20498.151.camel@irongate.swansea.linux.org.uk>
References: <m1hegnky2h.fsf@frodo.biederman.org>
	<20020918.132334.102949210.davem@redhat.com>
	<1032381789.20498.151.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 18 Sep 2002 21:43:09 +0100
   
   The inb timing depends on the PCI bus. If you want proof set a Matrox
   G400 into no pci retry mode, run a large X load at it and time some inbs
   you should be able to get to about 100 milliseconds for an inb to
   execute
   
Matrox isn't using inb/outb instructions to IO space, it is being
accessed by X using MEM space which is done using normal load and
store instructions on x86 after the card is mmap()'d into user space.
