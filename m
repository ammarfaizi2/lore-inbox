Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272119AbRHVVOc>; Wed, 22 Aug 2001 17:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272123AbRHVVOY>; Wed, 22 Aug 2001 17:14:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20864 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272119AbRHVVOK>;
	Wed, 22 Aug 2001 17:14:10 -0400
Date: Wed, 22 Aug 2001 14:14:02 -0700 (PDT)
Message-Id: <20010822.141402.78709010.davem@redhat.com>
To: groudier@free.fr
Cc: gibbs@scsiguy.com, axboe@suse.de, skraw@ithnet.com,
        phillips@bonn-fries.net, linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010822223658.X932-100000@gerard>
In-Reply-To: <20010822.114620.77339267.davem@redhat.com>
	<20010822223658.X932-100000@gerard>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=big5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by leeloo.zip.com.au id HAA02287

   From: Gérard Roudier <groudier@free.fr>
   Date: Wed, 22 Aug 2001 23:07:47 +0200 (CEST)

   Note that the manual says that the device will not use DAC if higher 32
   bits are zero. Nor I remember of any errata about the device behaving
   this way. But, as sym53c8xx device actually trying to do 64 bit PCI
   addressing should have been pretty rare for now, not all errata on this
   point should have been discovered (just trying to guess ...).

If I do not set DDAC in sym53c8xx it issues DAC cycles for everything,
even addresses with no bits set in upper 32-bits of address.

You will remember, we had this issue long ago and had to add #define
for it (which dies in my pci64 changes becuase this portability
issue no longer exists with proper API present).

Later,
David S. Miller
davem@redhat.com
ı:.Ë›±Êâmçë¢kaŠÉb²ßìzwm…ébïîË›±Êâmébìÿ‘êçz_âØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Ş—ú+€Ê+zf£¢·hšˆ§~†­†Ûiÿÿïêÿ‘êçz_è®æj:+v‰¨ş)ß£ømšSåy«­æ¶…­†ÛiÿÿğÃí»è®å’i
