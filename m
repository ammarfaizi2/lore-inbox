Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbTHUG5r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 02:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbTHUG5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 02:57:47 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:20476 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S262467AbTHUGXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 02:23:36 -0400
Subject: Re: usb-storage: how to ruin your hardware(?)
From: Martin Schlemmer <azarah@gentoo.org>
To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200308210205.h7L25PI6012011@wildsau.idv.uni.linz.at>
References: <200308210205.h7L25PI6012011@wildsau.idv.uni.linz.at>
Content-Type: text/plain
Message-Id: <1061446640.3390.51.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 21 Aug 2003 08:17:20 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-21 at 04:05, H.Rosmanith (Kernel Mailing List) wrote:
> -- Start of PGP signed section.
> > For the vast majority of USB storage devices, it's not possible to kill the
> > device like you did.
> > 
> > It looks like the device firmware needs certain data on the first sector to
> > operate.  The usb-storage communication is working just fine, but the
> > device is refusing commands.
> 
> aha. do you know why the device is refusing commands? it relys on sector0
> to contain some vital information and if this is not there, it refuses
> commands?
> 

We sell a make of flashdisk (what we call your 'usb bar') that use
sector 0 with its encryption scheme.  Basically as soon as you
'encrypt' or 'password protect' or whatever the device, you cannot
get a valid partition table, and sector 0 is not writable, so
repartitioning fails.  I have not tried to just put a fs on the
whole disk, but I assume it will fail as well, as it should start
at sector 0.

Anyhow, the only way to fix this if you lost the password, is to
format the device with the software that comes with the device
(windows based only for ours) - might be the same thing your side,
you just got the device into  'lock down mode' via some fluke.

Hope this might be of some help, else take it back.  Our side
at least if not burned or damaged, we would replace it.


Regards,

-- 
Martin Schlemmer


