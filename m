Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269512AbTG1OQc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 10:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269950AbTG1OQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 10:16:25 -0400
Received: from ns.suse.de ([213.95.15.193]:25094 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269512AbTG1OPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 10:15:40 -0400
Date: Mon, 28 Jul 2003 16:29:52 +0200
From: Stefan Reinauer <stepan@suse.de>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: linux-kernel@vger.kernel.org, Andries Brouwer <aebr@win.tue.nl>
Subject: Re: 2.6.0-test2 has i8042 mux problems
Message-ID: <20030728142952.GA1341@suse.de>
References: <Pine.LNX.4.53.0307271906020.18444@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307271906020.18444@twinlark.arctic.org>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.6.0-test1-1-athlon on an i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* dean gaudet <dean-list-linux-kernel@arctic.org> [030728 04:13]:
> i've got a box on which 2.4.x works fine, but 2.6.0-test2 gets into a snit
> when it's trying to initialize the i8042.  i can get 2.6.0-test2 to boot
> if i add "i8042_nomux".
> 
> the mux initialization code seems kind of ... wonk -- it seems to write
> values to the registers then read back and if the value is the same then
> it assumes the mux is there.  that seems way too likely to be broken in
> situations when the mux isn't there... it'd be better to be looking for
> some value which is different after writing.
> 
> the southbridge in this system is the ali1563.  if it helps i can supply a
> complete trace of in/out on ports 0x60 and 0x64.
 
I can confirm this. I have an Amilo A laptop with the following sb:
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]

without "i8042_nomux" the keyboard is recognized fine, but no mouse is
found on the mux. With the option everything works fine.

Stepan


