Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129393AbRCZWAU>; Mon, 26 Mar 2001 17:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129443AbRCZWAJ>; Mon, 26 Mar 2001 17:00:09 -0500
Received: from pc57-cam4.cable.ntl.com ([62.253.135.57]:11138 "EHLO
	kings-cross.london.uk.eu.org") by vger.kernel.org with ESMTP
	id <S129393AbRCZV77>; Mon, 26 Mar 2001 16:59:59 -0500
X-Mailer: exmh version 2.1.1 10/15/1999 (debian)
To: "Eric S. Raymond" <esr@snark.thyrsus.com>
cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        trini@kernel.crashing.org, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML1 cleanup patch, take 3 
In-Reply-To: Message from "Eric S. Raymond" <esr@snark.thyrsus.com> 
   of "Mon, 26 Mar 2001 14:24:58 CDT." <200103261924.f2QJOwL19694@snark.thyrsus.com> 
In-Reply-To: <200103261924.f2QJOwL19694@snark.thyrsus.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 26 Mar 2001 22:58:57 +0100
From: Philip Blundell <philb@gnu.org>
Message-Id: <E14hf0s-0001Cg-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    if [ "$CONFIG_PRINTER" != "n" ]; then
>-      bool '    Support IEEE1284 status readback' CONFIG_PRINTER_READBACK
>+      bool '    Support IEEE1284 status readback' CONFIG_PARPORT_1284
>    fi

This isn't really right.  Although it's true that CONFIG_PARPORT_1284 enables 
the stuff that used to be controlled by CONFIG_PRINTER_READBACK, the two 
aren't synonymous.  The m68k port ought to just use drivers/parport/Config.in 
like everybody else.

p.


