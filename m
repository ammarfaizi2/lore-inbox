Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291742AbSBXWrc>; Sun, 24 Feb 2002 17:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291738AbSBXWrW>; Sun, 24 Feb 2002 17:47:22 -0500
Received: from pizda.ninka.net ([216.101.162.242]:9626 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291729AbSBXWrH>;
	Sun, 24 Feb 2002 17:47:07 -0500
Date: Sun, 24 Feb 2002 14:44:23 -0800 (PST)
Message-Id: <20020224.144423.104049454.davem@redhat.com>
To: vojtech@suse.cz
Cc: paulus@samba.org, hozer@drgw.net, dalecki@evision-ventures.com,
        torvalds@transmeta.com, andre@linuxdiskcert.org, riel@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: Flash Back -- kernel 2.1.111
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020224233937.B2257@ucw.cz>
In-Reply-To: <20020224231002.B2199@ucw.cz>
	<15481.26697.420856.1109@argo.ozlabs.ibm.com>
	<20020224233937.B2257@ucw.cz>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Vojtech Pavlik <vojtech@suse.cz>
   Date: Sun, 24 Feb 2002 23:39:37 +0100
   
   > > happens if you plug in a 66MHz non-capable card to the 50 MHz bus.
   > 
   > The bus speed drops to 33MHz.
   
   Interesting. I'd expect 25 myself ... then we'll definitely need two
   clock values in struct pci_bus - because the hi-speed one isn't always a
   double the low one - as shown by your example.

You only need one, the current active one.

If you think that hot-plug is an issue, the arch dependant could would
need to recalculate the "current bus speed" and all would be fine.

So why do we need two values?
