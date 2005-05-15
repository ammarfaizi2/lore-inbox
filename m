Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262811AbVEOMFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbVEOMFG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 08:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbVEOMFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 08:05:06 -0400
Received: from gate.crashing.org ([63.228.1.57]:16336 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262811AbVEOMFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 08:05:02 -0400
Subject: Re: [PATCH 7/8] ppc64: SPU file system
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       Anton Blanchard <anton@samba.org>
In-Reply-To: <20050515090705.GA2343@elf.ucw.cz>
References: <200505132117.37461.arnd@arndb.de>
	 <200505132129.07603.arnd@arndb.de> <1116027079.5128.32.camel@gaston>
	 <20050515090705.GA2343@elf.ucw.cz>
Content-Type: text/plain
Date: Sun, 15 May 2005 22:02:28 +1000
Message-Id: <1116158548.5095.17.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > ioctl's are generally considered evil ... what about a write() method
> > writing a command ?
> 
> That's even more evil than ioctl()... Try doing 32-vs-64bit conversion
> on write...

I don't see the problem ... if you are passing a structure, you have to
convert it anyway, and it's bad practice. I was thinking about passing
ascii so it can be controlled by shell scripts.

Ben.


