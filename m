Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293182AbSCAPeN>; Fri, 1 Mar 2002 10:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293203AbSCAPeD>; Fri, 1 Mar 2002 10:34:03 -0500
Received: from pizda.ninka.net ([216.101.162.242]:2182 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293182AbSCAPdv>;
	Fri, 1 Mar 2002 10:33:51 -0500
Date: Fri, 01 Mar 2002 07:31:42 -0800 (PST)
Message-Id: <20020301.073142.24904941.davem@redhat.com>
To: jurgen@pophost.eunet.be
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: 2.4.19pre2 - USB - sparc64 compile problem
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C7F8B80.1010007@pophost.eunet.be>
In-Reply-To: <3C7F8B80.1010007@pophost.eunet.be>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jurgen Philippaerts <jurgen@pophost.eunet.be>
   Date: Fri, 01 Mar 2002 15:09:04 +0100

   hcd.c: In function `usb_hcd_pci_probe':
   hcd.c:627: `irq' undeclared (first use in this function)
   hcd.c:627: (Each undeclared identifier is reported only once
   hcd.c:627: for each function it appears in.)

Go to line 627 in an editor and change "irq" to be "dev->irq"

The same build failure got introduced when this code was merged
into the 2.5.x tree and I had to fix it there too.
