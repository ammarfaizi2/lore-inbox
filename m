Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbTETMye (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 08:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263769AbTETMye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 08:54:34 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:41912
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263766AbTETMyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 08:54:33 -0400
Subject: Re: Machin dependent serial port patches
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jcwren@jcwren.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200305192056.00610.jcwren@jcwren.com>
References: <200305192056.00610.jcwren@jcwren.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053432549.30546.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 20 May 2003 13:09:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-20 at 01:56, J.C. Wren wrote:
> 	One of the things I noticed in the port of 2.5.69 to the 386EX embedded 
> system is that serial.h appears to not be a mach-xxx positionable file.  The 
> 386EX board uses standard 8250 type serial ports, but at 3.6864Mhz instad of 
> 1.8432Mhz.  There appears to be no way to build a patch set without modifying 
> include/i386/serial.h.  Would this not be better places in mach-defaults?  
> I'm trying very hard to modify as few files as possible when building these 
> patch sets.

Making asm-i386/serial.h include a mach- file sounds the right thing to
do. mach- for x86 is pretty new so a lot of stuff that maybe should be
in it, hasnt migrated yet.

The counter argument however is that you should be able to use setserial
to adjust the baud base so you dont need to change anything 8)

