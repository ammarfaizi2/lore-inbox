Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291690AbSBALFx>; Fri, 1 Feb 2002 06:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291692AbSBALFo>; Fri, 1 Feb 2002 06:05:44 -0500
Received: from pizda.ninka.net ([216.101.162.242]:51588 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291690AbSBALF3>;
	Fri, 1 Feb 2002 06:05:29 -0500
Date: Fri, 01 Feb 2002 03:03:45 -0800 (PST)
Message-Id: <20020201.030345.70220779.davem@redhat.com>
To: kaos@ocs.com.au
Cc: brand@jupiter.cs.uni-dortmund.de, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <9496.1012559332@ocs3.intra.ocs.com.au>
In-Reply-To: <200202011007.g11A7hsc008080@tigger.cs.uni-dortmund.de>
	<9496.1012559332@ocs3.intra.ocs.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Keith Owens <kaos@ocs.com.au>
   Date: Fri, 01 Feb 2002 21:28:52 +1100

   On Fri, 01 Feb 2002 11:07:42 +0100, 
   Horst von Brand <brand@jupiter.cs.uni-dortmund.de> wrote:
   >libc.a was invented precisely to handle such stuff automatically when
   >linking... if it doesn't work, it should be fixed. I.e., making .a --> .o
   >is a step in the wrong direction IMVHO.
   
   There are two contradictory requirements.  crc32.o must only be linked
   if anything in the kernel needs it, linker puts crc32.o after the code
   that uses it.  crc32.o must be linked before anything that uses it so
   the crc32 __init code can initialize first.
   
Horst isn't even talking about the initcall issues, he's talking about
how linking with libc works in that it only brings in the routines you
actually reference.

Will you get over the initcall thing already, you must be dreaming
about it at this point. I mean really, just GET OVER IT. :-)
