Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267494AbTBLPsv>; Wed, 12 Feb 2003 10:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267500AbTBLPsv>; Wed, 12 Feb 2003 10:48:51 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:41743 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267494AbTBLPst>; Wed, 12 Feb 2003 10:48:49 -0500
Date: Wed, 12 Feb 2003 15:58:33 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Thomas Molina <tmolina@cox.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: problems with console configuration
In-Reply-To: <Pine.LNX.4.44.0302112303020.7475-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0302121556090.31435-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I've seen a number of postings to the list complaining of output to the 
> console ceasing after the Uncompressing Linux line at the beginning of 
> boot.  I ran into this myself.  
> 
> I believe one cause of this is the new console on framebuffer console 
> configuration option.  I believe some people are not turning on the 
> option, but then are trying to output to the framebuffer by selecting a 
> video mode which does that.

The reason is because the framebuffer layer can run without the VT console 
system. You cna even run fbdev with vgacon if the driver supports it.
 
> I've also ran into what seems an anomaly in the configuration options.  If 
> Input device selection is set to modular (CONFIG_INPUT) then it doesn't 
> seem to be possible to turn on virtual terminal (CONFIG_VT) or support for 
> console on virtual terminal (CONFIG_VT_CONSOLE).  At least in make 
> menuconfig, those  options don't appear if the former isn't set to y.  It 
> is going to be rather difficult to see console output if those aren't  
> available isn't it?

The console system is layered on top of the input layer. Now all keyboards 
are being ported over to one api. This is a plus :-)


