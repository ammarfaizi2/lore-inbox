Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267529AbSLLVZg>; Thu, 12 Dec 2002 16:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267530AbSLLVZg>; Thu, 12 Dec 2002 16:25:36 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:12554 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267529AbSLLVZf>;
	Thu, 12 Dec 2002 16:25:35 -0500
Date: Thu, 12 Dec 2002 22:32:58 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, John Bradford <john@grabjohn.com>,
       perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.5.51 breaks ALSA AWE32
Message-ID: <20021212213258.GB11836@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Sam Ravnborg <sam@ravnborg.org>, John Bradford <john@grabjohn.com>,
	perex@suse.cz, linux-kernel@vger.kernel.org
References: <20021212205206.GA11836@mars.ravnborg.org> <Pine.LNX.4.44.0212121454290.17517-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212121454290.17517-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On tor, dec 12, 2002 at 02:55:28 -0600, Kai Germaschewski wrote:
> Nope, kbuild does that for you ;)

I recall this - now. Anyway the following fragment teels the full story :-)
cmd_link_multi-y = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) -r -o $@ $(filter $(addprefix $(obj)/,$($(subst $(obj)/,,$(@:.o=-objs))) $($(subst $(obj)/,,$(@:.o=-y)))),$^)

In clear text:
For all prerequisite .o files (file.o) where there exist a -objs (file-objs)
or a -y (file-y) variable use the value of that variable instead.

> (And yes, lots of places still do it manually, but it's not necessary 
> anymore).

I will take a look some day.

	Sam
