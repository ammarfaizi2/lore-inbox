Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263089AbRFAQ0i>; Fri, 1 Jun 2001 12:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263598AbRFAQ03>; Fri, 1 Jun 2001 12:26:29 -0400
Received: from vagabond.btnet.cz ([62.80.85.77]:19072 "EHLO vagabond.btnet.cz")
	by vger.kernel.org with ESMTP id <S263089AbRFAQ0M>;
	Fri, 1 Jun 2001 12:26:12 -0400
Date: Fri, 1 Jun 2001 18:25:33 +0200
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: ifconfig freezes in 2.4.5
Message-ID: <20010601182533.A432@vagabond>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When I compiled and booted 2.4.5, the machine got stuck in

ifconfig lo 127.0.0.1

(SysRq still worked, ^C did not seem to).
I tried to strace it. Last thing strace managed to write was:

ioctl(4, 0x8914

(no comma, not including the trird argument). I tried to switch of some
compile-time parameters I changed from 2.4.4, but problem persisted.
After reversing 2.4.5 patch and recompiling the kernel (using exactly the
same config), the problem dispaeared.

I include the .config used. I'll try to gen any aother information you might
consider some use, but currently have no idea what it might be.

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
