Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318631AbSHLDIv>; Sun, 11 Aug 2002 23:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318641AbSHLDIv>; Sun, 11 Aug 2002 23:08:51 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28056 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318631AbSHLDIv>;
	Sun, 11 Aug 2002 23:08:51 -0400
Date: Sun, 11 Aug 2002 19:59:06 -0700 (PDT)
Message-Id: <20020811.195906.107999483.davem@redhat.com>
To: kaos@ocs.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unix-domain sockets - abstract addresses 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <649.1029121193@kao2.melbourne.sgi.com>
References: <Pine.LNX.4.44.0208112132510.25011-100000@waste.org>
	<649.1029121193@kao2.melbourne.sgi.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Keith Owens <kaos@ocs.com.au>
   Date: Mon, 12 Aug 2002 12:59:53 +1000

   On Sun, 11 Aug 2002 21:35:05 -0500 (CDT), 
   Oliver Xymoron <oxymoron@waste.org> wrote:
   >Might it be simpler to change the overall module name? unix.o is an
   >especially poor choice of names, compiler defines aside.
   
   I prefer that option, expect that it changes the name of a module.  Not
   that we haven't done that before ...
   
   A module name of af_unix would be much better, like af_packet.  It
   would require changing the name of af_unix.c (source and conglomerate
   objects cannot have the same basename) and a change to modutils to map
   net-pf-1 to af_unix.

I don't like this solution, please fix this right and get rid of the
limitations at their source.

If I name a module "foo" and this causes "fo" to become a defined
CPP symbol in when compiling the sources for that module, that is
completely broken!

net/unix is just a trite example.  How about a driver for device "foo"
that has a member "foo" in one of it's structures?  They have to get
this undef thing too or rename their module, that's rediculious.
