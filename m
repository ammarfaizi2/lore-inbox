Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbULEMv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbULEMv3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 07:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbULEMv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 07:51:29 -0500
Received: from linaeum.absolutedigital.net ([63.87.232.45]:49821 "EHLO
	linaeum.absolutedigital.net") by vger.kernel.org with ESMTP
	id S261299AbULEMv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 07:51:28 -0500
Date: Sun, 5 Dec 2004 07:50:49 -0500 (EST)
From: Cal Peake <cp@absolutedigital.net>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-rc3 oops when 'modprobe -r dvb-bt8xx'
In-Reply-To: <41B2F651.5030803@eyal.emu.id.au>
Message-ID: <Pine.LNX.4.61.0412050742220.31025@linaeum.absolutedigital.net>
References: <Pine.LNX.4.58.0412031611460.22796@ppc970.osdl.org>
 <41B1BD24.4050603@eyal.emu.id.au> <Pine.LNX.4.61.0412050455440.27512@linaeum.absolutedigital.net>
 <41B2F651.5030803@eyal.emu.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Dec 2004, Eyal Lebedinsky wrote:

> Not good. My rc.boot/local has this line
> 	modprobe dvb_bt8xx
> 	modprobe v4l1-compat
> 	modprobe sp887x
> 	modprobe mt352
> 
> and this now seems to generate an oops (see end of boot log).

Yes, that is a bad patch, I missed part of what the i2c_info function was 
doing. It looks like this isn't going to be able to be solved with a 
simple patch.

For the time being if you need to remove/reload the modules I'd try using 
'rmmod' instead of 'modprobe -r' - you might be able to avoid the oops by 
removing modules one by one in a strict order.

If that's not feasible I'd stick with the -mm4 tree or pre-rc2 until the 
-mm changes go into mainline.

-- Cal

