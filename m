Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbTL2PCi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 10:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263518AbTL2PCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 10:02:38 -0500
Received: from mail.aei.ca ([206.123.6.14]:1008 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S263513AbTL2PCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 10:02:35 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: Gabor MICSKO <gmicsko@szintezis.hu>
Subject: Re: Blank Screen in 2.6.0
Date: Mon, 29 Dec 2003 10:02:21 -0500
User-Agent: KMail/1.5.93
Cc: dan@eglifamily.dnsalias.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0312282303340.15994-100000@eglifamily.dnsalias.net>
In-Reply-To: <Pine.LNX.4.44.0312282303340.15994-100000@eglifamily.dnsalias.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200312291002.22262.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 28, 2003 06:08 pm, dan@eglifamily.dnsalias.net wrote:
> On 28 Dec 2003, Gabor MICSKO wrote:
> > http://www.linux.org.uk/~davej/docs/post-halloween-2.6.txt
>
> I tried that.
>
>
> Known gotchas.
> ~~~~~~~~~~~~~~
> Certain known bugs are being reported over and over. Here are the
> workarounds.
> - Blank screen after decompressing kernel?
>   Make sure your .config has
>    CONFIG_INPUT=y
>    CONFIG_VT=y
>    CONFIG_VGA_CONSOLE=y
>    CONFIG_VT_CONSOLE=y
>   A lot of people have discovered that taking their .config from 2.4 and
>   running make oldconfig to pick up new options leads to problems, notably
>   with CONFIG_VT not being set.
>
> ok, so I grep'ed the .config
>
> [root@eglifamily kernel]# grep -wi config_input .config
> CONFIG_INPUT=y
> [root@eglifamily kernel]# grep -wi config_vt .config
> CONFIG_VT=y
> [root@eglifamily kernel]# grep -wi config_vga_console .config
> CONFIG_VGA_CONSOLE=y
> [root@eglifamily kernel]# grep -wi config_vt_console .config
> CONFIG_VT_CONSOLE=y
> [root@eglifamily kernel]#
>
> you can see that in the .config I attched:
> > > CONFIG_INPUT=y
> > > CONFIG_VT=y
> > > CONFIG_VT_CONSOLE=y
> > > CONFIG_VGA_CONSOLE=y
>
> Any other ideas?

I had problems getting 2.6.0 to work on a second box too.  What seemed to solve
it here was defining the fonts:

CONFIG_PCI_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

Luck,
Ed Tomlinson
