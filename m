Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315358AbSHVR2h>; Thu, 22 Aug 2002 13:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315337AbSHVR1k>; Thu, 22 Aug 2002 13:27:40 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:39667 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315278AbSHVR1d>; Thu, 22 Aug 2002 13:27:33 -0400
Subject: Re: Patch for PC keyboard driver's autorepeat-rate handling
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dave Jones <davej@suse.de>, James Simmons <jsimmons@transvirtual.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0208221153210.672-100000@ida.rowland.org>
References: <Pine.LNX.4.33L2.0208221153210.672-100000@ida.rowland.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 22 Aug 2002 18:31:02 +0100
Message-Id: <1030037462.3090.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-22 at 16:59, Alan Stern wrote:
> properly?  The error is not in the program; it's in the kernel's
> handling of the KDKBDREP ioctl.  This patch fixes the following three
> mistakes:
> 
> 	The .rate member of struct kbd_repeat is actually a repeat
> 	_period_ measured in msec; the driver interprets it as a
> 	repeat _rate_ in characters per second.
> 
> 	The driver returns the _prior_ values of the rate and delay
> 	settings rather than the _current_ values.
> 
> 	The driver looks for an exact match for the rate and delay
> 	values rather than using the closest match.

Since its done what it does now since about 1991, it would be better to
fix the documentation if in fact there is an error.

> Incidentally, does anybody know why drivers/char/pc_keyb.c hasn't been
> moved to the arch/i386 part of the directory tree?

"PC" keyboard and PS/2 mouse hardware can appear on almost any system,
even on plug in PCI cards.

