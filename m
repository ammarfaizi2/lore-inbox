Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317512AbSHNCxZ>; Tue, 13 Aug 2002 22:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319180AbSHNCxZ>; Tue, 13 Aug 2002 22:53:25 -0400
Received: from surf.cadcamlab.org ([156.26.20.182]:53129 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S317512AbSHNCxY>; Tue, 13 Aug 2002 22:53:24 -0400
Date: Tue, 13 Aug 2002 21:57:01 -0500
To: Greg Banks <gnb@alphalink.com.au>
Cc: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [patch] config language dep_* enhancements
Message-ID: <20020814025701.GL761@cadcamlab.org>
References: <3D587483.1C459694@alphalink.com.au> <Pine.LNX.4.44.0208131306040.6035-100000@chaos.physics.uiowa.edu> <20020813204829.GJ761@cadcamlab.org> <3D59B212.DC24E231@alphalink.com.au> <20020814014241.GK761@cadcamlab.org> <3D59BFF5.2C3B4B6A@alphalink.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D59BFF5.2C3B4B6A@alphalink.com.au>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Greg Banks]
>     define_bool CONFIG_QUUX y
> 
>     bool 'Set this symbol to ON' CONFIG_FOO
> 
>     if [ "$CONFIG_FOO" = "y" ]; then
> 	bool 'Here QUUX is a query symbol' CONFIG_QUUX
>     fi

It's (somewhat) well-known that things tend to fly apart when you try
to redefine a symbol.  I don't see it documented, but I suppose it
should be.  In any case, you're supposed to use "else" - see the
example in config-language.txt under "=== define_hex".

Peter
