Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbVC3H1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbVC3H1p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 02:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVC3H1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 02:27:45 -0500
Received: from pirx.hexapodia.org ([199.199.212.25]:40296 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S261804AbVC3H01
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 02:26:27 -0500
Date: Tue, 29 Mar 2005 23:26:27 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: dtor_core@ameritech.net
Cc: Stefan Seyfried <seife@suse.de>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Message-ID: <20050330072627.GB27870@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50005032506582451d581@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 09:58:40AM -0500, Dmitry Torokhov wrote:
> I wonder why ALPS reconnect failed. You don't have a serial console
> set up, do you? If not then maybe you could make a huge framebuffer to
> capture as much info as you can... I hope you have a digital camera ;)

No serial ports brought out on this laptop, and I've not tried
framebuffer...

> Then do "echo 1 > /sys/modules/i8042/parameters/debug" and try to
> suspend. I am interested of data coming in and out of i8042.

Transcribed by hand, the last few bytes are
< fa           ACK
> d4 e9        GETINFO
< fa 20 00 64  
> d4 ff        RESET_BAT
< fa aa 00     RET_BAT

(Because I used O= the __FILE__ is very long so each dbg() takes two lines
of my 80x25 console...)

Dunno if that's helpful, sorry...

-andy
