Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291281AbSBMAs5>; Tue, 12 Feb 2002 19:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291280AbSBMAsr>; Tue, 12 Feb 2002 19:48:47 -0500
Received: from pizda.ninka.net ([216.101.162.242]:31880 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291272AbSBMAsa>;
	Tue, 12 Feb 2002 19:48:30 -0500
Date: Tue, 12 Feb 2002 16:46:36 -0800 (PST)
Message-Id: <20020212.164636.21927297.davem@redhat.com>
To: pavel@suse.cz
Cc: davidm@hpl.hp.com, anton@samba.org, linux-kernel@vger.kernel.org,
        zippel@linux-m68k.org
Subject: Re: thread_info implementation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020212171421.GE148@elf.ucw.cz>
In-Reply-To: <15464.34183.282646.869983@napali.hpl.hp.com>
	<20020211.190449.55725714.davem@redhat.com>
	<20020212171421.GE148@elf.ucw.cz>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pavel Machek <pavel@suse.cz>
   Date: Tue, 12 Feb 2002 18:14:22 +0100

   > The thing is going to be fully hot in the cache all the time, there
   > is no way you'll take a cache miss for this dereference.
   
   So you essentially made your cache one cacheline smaller.

Not at all, that cacheline has to be in the cache anyways because
it also holds all the other information which needs to be accessed
during trap entry/exit.

Try again.
