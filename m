Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280812AbRKOLm3>; Thu, 15 Nov 2001 06:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280818AbRKOLmT>; Thu, 15 Nov 2001 06:42:19 -0500
Received: from pizda.ninka.net ([216.101.162.242]:49550 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280812AbRKOLmN>;
	Thu, 15 Nov 2001 06:42:13 -0500
Date: Thu, 15 Nov 2001 03:41:36 -0800 (PST)
Message-Id: <20011115.034136.73653260.davem@redhat.com>
To: anton@samba.org
Cc: groudier@free.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] small sym-2 fix
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011115223526.A27258@krispykreme>
In-Reply-To: <20011115153654.E22552@krispykreme>
	<20011115.021916.45712781.davem@redhat.com>
	<20011115223526.A27258@krispykreme>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Anton Blanchard <anton@samba.org>
   Date: Thu, 15 Nov 2001 22:35:26 +1100
    
   > Are you using 4K pages on ppc64? :-(
   
   Unfortunately so. We will definitely be looking to decouple hardware and
   software page sizes (like sparc64 is doing) once things stabilise, a
   4KB page size is pretty small for a 64 bit arch.

Using an 8K page size should really be transparent to
any sane ELF userland, why not just do it?  Is there
some hardcoded dependency in the ppc ELF stuff or is
it just a "some of our kernel code still assumes PAGE_SIZE
= 4K"?

