Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbTKQUXv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 15:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbTKQUXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 15:23:51 -0500
Received: from gaia.cela.pl ([213.134.162.11]:16389 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S261877AbTKQUXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 15:23:50 -0500
Date: Mon, 17 Nov 2003 21:23:31 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Andrew Pimlott <andrew@pimlott.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_CRC32 in 2.4.22 breaks PCMCIA
In-Reply-To: <20031117200451.GA12931@pimlott.net>
Message-ID: <Pine.LNX.4.44.0311172121400.3939-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> CONFIG_CRC32 was introduced in 2.4.22.  I found that if I didn't
> explicitly set it, the pcnet_cs driver from stand-alone PCMCIA
> distribution didn't work.  PCMCIA relies on the crc functions, and
> since they were always available before 2.4.22, it doesn't check for
> them.

Something wrong with the in-kernel pcnet_cs?

> This seems to be significant breakage, and it took me a good while
> to figure out what was going on.  Is this change reasonable in the
> stable kernel series?

Well, it's in the help for the CRC32 option that it's available to enable 
external-kernel tree drivers to access these functions.  If you are 
running make oldconfig you'll hit the question and if you don't know what 
it's about you should consult help...
Seems reasonable to me.  Same aplies to deflate, etc. support routines.

Cheers,
MaZe.


