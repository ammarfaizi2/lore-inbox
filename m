Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267273AbSKSUrb>; Tue, 19 Nov 2002 15:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267290AbSKSUrb>; Tue, 19 Nov 2002 15:47:31 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:523 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267273AbSKSUr2>;
	Tue, 19 Nov 2002 15:47:28 -0500
Date: Tue, 19 Nov 2002 21:54:30 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [RFC/CFT] Separate obj/src dir
Message-ID: <20021119205430.GC15161@mars.ravnborg.org>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
References: <20021119202931.GA15161@mars.ravnborg.org> <Pine.LNX.3.95.1021119153545.6004A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1021119153545.6004A-100000@chaos.analogic.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 03:46:28PM -0500, Richard B. Johnson wrote:
> Different configurations are handled with different ".config"
> files.
And different .config files results in different kernels.
Please note that .config files are also located in OBJTREE.

Cosider something like the following:

~/bk/linux-2.5
~/compile/arm	  <= Used to check that the kernel compiles for ARM
~/compile/allmod  <= My config with a lot of modules
~/compile/machine <= The config I use on my machine
~/compile/work    <= That's my sandbox

All configurations share the same src.
During the last copule of days we have seen some header file
clean-ups. It would have been nice if they tried compiling in
all four configurations listed above.
But if I switch .config then it is often a recompile of everything,
whereas the above setup can minimize it.
The header file cleanup is maybe not the best example because touching
a few key header files requires recompilation of everything anyway.

But my point is that there is a good use of different configurations
based on the same src.

Others that have asked for separate obj dir may step in here,
explaining why they thougt it was good.

	Sam
