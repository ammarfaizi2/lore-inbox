Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291454AbSBAAcr>; Thu, 31 Jan 2002 19:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291457AbSBAAci>; Thu, 31 Jan 2002 19:32:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:33920 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291454AbSBAAc1>;
	Thu, 31 Jan 2002 19:32:27 -0500
Date: Thu, 31 Jan 2002 16:30:54 -0800 (PST)
Message-Id: <20020131.163054.41634626.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: vandrove@vc.cvut.cz, torvalds@transmeta.com, garzik@havoc.gtf.org,
        linux-kernel@vger.kernel.org, paulus@samba.org, davidm@hpl.hp.com,
        ralf@gnu.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E16WRmu-0003iO-00@the-village.bc.nu>
In-Reply-To: <20020131.162549.74750188.davem@redhat.com>
	<E16WRmu-0003iO-00@the-village.bc.nu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Fri, 1 Feb 2002 00:42:44 +0000 (GMT)
   
   I'd like to eliminate lots of the magic weird cases in Config.in too - but
   by making the language express it. Something like
   
   tristate_orif "blah" CONFIG_FOO $CONFIG_SMALL
   
This doesn't solve the CRC32 case.  What if you want
CONFIG_SMALL, yet some net driver that needs the crc32
routines?
