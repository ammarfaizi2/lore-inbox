Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbTL1XIR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 18:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbTL1XIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 18:08:17 -0500
Received: from c-67-166-107-168.client.comcast.net ([67.166.107.168]:52358
	"EHLO eglifamily.dnsalias.net") by vger.kernel.org with ESMTP
	id S262161AbTL1XIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 18:08:12 -0500
Date: Sun, 28 Dec 2003 23:08:10 +0000 (UTC)
From: dan@eglifamily.dnsalias.net
To: Gabor MICSKO <gmicsko@szintezis.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Blank Screen in 2.6.0
In-Reply-To: <1072640441.720.1.camel@sunshine>
Message-ID: <Pine.LNX.4.44.0312282303340.15994-100000@eglifamily.dnsalias.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SA-Exim-Mail-From: dan@eglifamily.dnsalias.net
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Dec 2003, Gabor MICSKO wrote:

> http://www.linux.org.uk/~davej/docs/post-halloween-2.6.txt
> 
> 
I tried that. 


Known gotchas.
~~~~~~~~~~~~~~
Certain known bugs are being reported over and over. Here are the
workarounds.
- Blank screen after decompressing kernel?
  Make sure your .config has
   CONFIG_INPUT=y
   CONFIG_VT=y
   CONFIG_VGA_CONSOLE=y
   CONFIG_VT_CONSOLE=y
  A lot of people have discovered that taking their .config from 2.4 and
  running make oldconfig to pick up new options leads to problems, notably
  with CONFIG_VT not being set.

ok, so I grep'ed the .config

[root@eglifamily kernel]# grep -wi config_input .config
CONFIG_INPUT=y
[root@eglifamily kernel]# grep -wi config_vt .config
CONFIG_VT=y
[root@eglifamily kernel]# grep -wi config_vga_console .config
CONFIG_VGA_CONSOLE=y
[root@eglifamily kernel]# grep -wi config_vt_console .config
CONFIG_VT_CONSOLE=y
[root@eglifamily kernel]#


you can see that in the .config I attched:

> > CONFIG_INPUT=y
> > CONFIG_VT=y
> > CONFIG_VT_CONSOLE=y
> > CONFIG_VGA_CONSOLE=y

Any other ideas?

--- Dan


