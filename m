Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbTEDSoy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 14:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTEDSoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 14:44:54 -0400
Received: from mail.zmailer.org ([62.240.94.4]:17073 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S261589AbTEDSow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 14:44:52 -0400
Date: Sun, 4 May 2003 21:57:16 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: KML <linux-kernel@vger.kernel.org>
Subject: Re: [2.5] Update sk98lin driver
Message-ID: <20030504185716.GI24892@mea-ext.zmailer.org>
References: <1052073847.4478.18.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052073847.4478.18.camel@nosferatu.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 04, 2003 at 08:44:07PM +0200, Martin Schlemmer wrote:
> Hi
> 
> I have a 3Com 3c940 gigabit LOM, that is basically a
> SysKonnect chipset card.  Here are later drivers that
> do support it:
>   ftp://ftp.asus.com.tw/pub/ASUS/lan/3com/3c940/041_Linux.zip
...> 
> Now the problem is that if I try to load it, I get this:
> -----------------------------------------
> sk98lin: Unknown symbol __udivdi3
> -----------------------------------------
> Meaning it linked with libgcc_s.so.  Any ideas why ?

  It wanted to.    That is signature of  64 bit value
  being divided by an abitrary non-power-of-two divider.

  If there is a non-fast-path use for the division,
  using   do_div()  macro.   Originally for   lib/vsprintf.c
  from which you can deduce the usage.

  If it is in fast-path,   then the code needs serious
  re-thought.

> If you need the diff from above source, let me know.  Else
> if somebody more experienced is interested in porting it,
> I will gladly test.
> Thanks,
> -- 
> Martin Schlemmer

/Matti Aarnio
