Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132395AbREHMmq>; Tue, 8 May 2001 08:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132500AbREHMmf>; Tue, 8 May 2001 08:42:35 -0400
Received: from [62.172.234.2] ([62.172.234.2]:24713 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S132416AbREHMmX>;
	Tue, 8 May 2001 08:42:23 -0400
Date: Tue, 8 May 2001 13:41:51 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
To: Keith Owens <kaos@melbourne.sgi.com>
cc: kdb@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: kdb wishlist
In-Reply-To: <23270.989323782@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.21.0105081335060.856-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith,

What would be really great is to add the following item to your wishlist:

* make it possible (it is trivial but a pain to have to do it manually
every time I upgrade to your latest version!) for those extra "modules" to
be statically linked in. So that one doesn't have to keep these lines
in the rc.local
  
if [ -f /proc/sys/kernel/kdb ]
then
        insmod kdbm_pg > /dev/null 2>&1
        insmod kdbm_vm > /dev/null 2>&1
fi

and then discover that the modules are from the compilation corresponding
to a different tweak in page.h or highmem or whatever (let him who readeth
understand ;)

Long time ago I suggested removing the infrastructure for these "modules"
completely (justification being -- it is not useless _only_ in a very
exotic case of the need to teach kdb new features on a running kernel 
without permission to reboot) but you objected and that is fine, but at
least making it optionally possible would be _very nice_, please.

Regards,
Tigran

