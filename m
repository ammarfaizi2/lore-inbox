Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbTETNpY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 09:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263773AbTETNpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 09:45:24 -0400
Received: from mail143.mail.bellsouth.net ([205.152.58.103]:54099 "EHLO
	imf56bis.bellsouth.net") by vger.kernel.org with ESMTP
	id S263653AbTETNpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 09:45:23 -0400
From: "J.C. Wren" <jcwren@jcwren.com>
Reply-To: jcwren@jcwren.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Machin dependent serial port patches
Date: Tue, 20 May 2003 09:57:14 -0400
User-Agent: KMail/1.5.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200305192056.00610.jcwren@jcwren.com> <1053432549.30546.5.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1053432549.30546.5.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305200957.14569.jcwren@jcwren.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	The only prolem with using setserial is my console is one one of these serial 
port (headless system.  I failed to mention that earlier).  So everything 
that comes out the console at the wrong rate :(  However, Milton D. Miller 
suggested looking at early_serial_rgister, which is used on ppc and ia64.  
That might help.

	--John

On Tuesday 20 May 2003 08:09 am, Alan Cox wrote:
> On Maw, 2003-05-20 at 01:56, J.C. Wren wrote:
> > 	One of the things I noticed in the port of 2.5.69 to the 386EX embedded
> > system is that serial.h appears to not be a mach-xxx positionable file. 
> > The 386EX board uses standard 8250 type serial ports, but at 3.6864Mhz
> > instad of 1.8432Mhz.  There appears to be no way to build a patch set
> > without modifying include/i386/serial.h.  Would this not be better places
> > in mach-defaults? I'm trying very hard to modify as few files as possible
> > when building these patch sets.
>
> Making asm-i386/serial.h include a mach- file sounds the right thing to
> do. mach- for x86 is pretty new so a lot of stuff that maybe should be
> in it, hasnt migrated yet.
>
> The counter argument however is that you should be able to use setserial
> to adjust the baud base so you dont need to change anything 8)
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

