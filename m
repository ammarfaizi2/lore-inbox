Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbTAJGka>; Fri, 10 Jan 2003 01:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263256AbTAJGka>; Fri, 10 Jan 2003 01:40:30 -0500
Received: from pizda.ninka.net ([216.101.162.242]:23685 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263228AbTAJGk0>;
	Fri, 10 Jan 2003 01:40:26 -0500
Date: Thu, 09 Jan 2003 22:40:06 -0800 (PST)
Message-Id: <20030109.224006.102700508.davem@redhat.com>
To: andersg@0x63.nu
Cc: Niels.denOtter@surfnet.nl, linux-kernel@vger.kernel.org
Subject: Re: 2.5.55: local symbols in net/ipv6/af_inet6.o
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030109231834.GD3345@gagarin>
References: <20030109091025.GW31387@surly.surfnet.nl>
	<20030109231834.GD3345@gagarin>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Anders Gustafsson <andersg@0x63.nu>
   Date: Fri, 10 Jan 2003 00:18:34 +0100

   On Thu, Jan 09, 2003 at 10:10:26AM +0100, Niels den Otter wrote:
   > The reference_discarded.pl script says following:
   >  pangsit:/usr/src/linux/net> perl ~otter/reference_discarded.pl 
   >  Finding objects, 245 objects, ignoring 0 module(s)
   >  Finding conglomerates, ignoring 11 conglomerate(s)
   >  Scanning objects
   >  Error: ./ipv6/af_inet6.o .init.text refers to 000003e4 R_386_PC32 .exit.text
   >  Done
   > 
   > I tried both gcc-2.95 & gcc-3.2.2 .
   
   This patch shoul fix it, the problem is that cleanup_ipv6_mibs can't be
   __exit as it's called on ipv6_init's errorpath.
   
I've applied your patch, thanks.
