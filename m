Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317329AbSGOFcD>; Mon, 15 Jul 2002 01:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317331AbSGOFcC>; Mon, 15 Jul 2002 01:32:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3523 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317329AbSGOFcB>;
	Mon, 15 Jul 2002 01:32:01 -0400
Date: Sun, 14 Jul 2002 22:25:27 -0700 (PDT)
Message-Id: <20020714.222527.57270686.davem@redhat.com>
To: benh@kernel.crashing.org
Cc: alan@lxorguk.ukuu.org.uk, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Removal of pci_find_* in 2.5
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020713134553.4483@192.168.4.1>
References: <20020713.135235.83621938.davem@redhat.com>
	<20020713134553.4483@192.168.4.1>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
   Date: Sat, 13 Jul 2002 15:45:53 +0200
   
   That case shouldn't be a problem, since when your device get discovered,
   hopefully, the host controller is already there. Though in some cases,
   host controllers just appear as a sibling device, and in this specific
   case, it may be not have been "discovered" yet.

THat's not what I'm concerned about, what I care about is that there
still will be a pci_find_*() I can call to see if DEV/ID is on
the bus.  That is the easiest way to perform that search right
now.
