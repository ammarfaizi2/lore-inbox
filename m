Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319471AbSH3AHg>; Thu, 29 Aug 2002 20:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319474AbSH3AHf>; Thu, 29 Aug 2002 20:07:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:9641 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319471AbSH3AHf>;
	Thu, 29 Aug 2002 20:07:35 -0400
Date: Thu, 29 Aug 2002 17:05:51 -0700 (PDT)
Message-Id: <20020829.170551.98069822.davem@redhat.com>
To: pavel@suse.cz
Cc: alan@lxorguk.ukuu.org.uk, ldb@ldb.ods.org, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH 1 / ...] i386 dynamic fixup/self modifying code
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020829232233.GA18573@atrey.karlin.mff.cuni.cz>
References: <20020828121129.A35@toy.ucw.cz>
	<1030663192.1326.20.camel@irongate.swansea.linux.org.uk>
	<20020829232233.GA18573@atrey.karlin.mff.cuni.cz>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pavel Machek <pavel@suse.cz>
   Date: Fri, 30 Aug 2002 01:22:33 +0200

   Aha, making a list and just patching early at boot is even simpler
   than method I was thinking about.... Why not do it that way?

Even more cleverly you could use subsections, and thus:

1) __init free the patch code blocks at the end of boot
2) patch them more simply, the .subsection entries would
   be "kern_addr, insn" __u32 pairs on x86 for example.


