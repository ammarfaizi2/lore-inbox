Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292091AbSBTRfE>; Wed, 20 Feb 2002 12:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292104AbSBTRes>; Wed, 20 Feb 2002 12:34:48 -0500
Received: from pizda.ninka.net ([216.101.162.242]:43136 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S292091AbSBTRce>;
	Wed, 20 Feb 2002 12:32:34 -0500
Date: Wed, 20 Feb 2002 09:30:34 -0800 (PST)
Message-Id: <20020220.093034.112623671.davem@redhat.com>
To: jgarzik@mandrakesoft.com
Cc: jmerkey@vger.timpanogas.org, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Subject: Re: ioremap()/PCI sickness in 2.4.18-rc2
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C73DC34.E83CCD35@mandrakesoft.com>
In-Reply-To: <20020220103320.A32211@vger.timpanogas.org>
	<20020220103539.B32211@vger.timpanogas.org>
	<3C73DC34.E83CCD35@mandrakesoft.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@mandrakesoft.com>
   Date: Wed, 20 Feb 2002 12:26:12 -0500
   
   type abuse aside, and alpha bugs aside, this looks ok... what is the
   value of as->msize?

Jeff and Jeff, the problem is one of two things:

1) when you have ~2GB of memory the vmalloc pool is very small
   and this it the same place ioremap allocations come from

2) the BIOS or Linus is not assigning resources of the device
   properly, or it simple can't because the available PCI MEM space
   with this much memory is too small

I note that one of the resources of the card is 16MB or so.
