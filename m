Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290809AbSARUkj>; Fri, 18 Jan 2002 15:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290810AbSARUkS>; Fri, 18 Jan 2002 15:40:18 -0500
Received: from pizda.ninka.net ([216.101.162.242]:59541 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290808AbSARUkI> convert rfc822-to-8bit;
	Fri, 18 Jan 2002 15:40:08 -0500
Date: Fri, 18 Jan 2002 12:38:37 -0800 (PST)
Message-Id: <20020118.123837.21900127.davem@redhat.com>
To: groudier@free.fr
Cc: hozer@drgw.net, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        rmk@arm.linux.org.uk, dan@embeddededge.com, mattl@mvista.com
Subject: Re: pci_alloc_consistent from interrupt == BAD
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020118210150.Q1937-100000@gerard>
In-Reply-To: <20020118130209.J14725@altus.drgw.net>
	<20020118210150.Q1937-100000@gerard>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Gérard Roudier <groudier@free.fr>
   Date: Fri, 18 Jan 2002 21:21:35 +0100 (CET)

   I have noted that some ports may [ever] require pci_alloc_consistent not
   to be called from interrupt context. Just I will look into this when time
   will allow.
   
Do not bother Gerard, these ports really are broken and
pci_alloc_consistent must work from interrupts.
   
   I am not going to ever use not cache coherent hardware, even if I am ready
   to make the sym driver work reliably on such brain-dead things. Just it is
   not high priority stuff for now.

Perhaps you misunderstand, it is not "lack of cache coherency" it is
"cache needs flushing around DMA transfers" and this is handled
perfectly by PCI DMA interfaces.  It is nothing you should be
concerned about.
