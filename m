Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318223AbSHMQQ1>; Tue, 13 Aug 2002 12:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318224AbSHMQQ1>; Tue, 13 Aug 2002 12:16:27 -0400
Received: from surf.cadcamlab.org ([156.26.20.182]:59271 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S318223AbSHMQQ0>; Tue, 13 Aug 2002 12:16:26 -0400
Date: Tue, 13 Aug 2002 11:20:04 -0500
To: Greg Banks <gnb@alphalink.com.au>, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
Message-ID: <20020813162004.GH761@cadcamlab.org>
References: <20020808151432.GD380@cadcamlab.org> <Pine.LNX.4.44.0208081142390.23063-100000@chaos.physics.uiowa.edu> <20020808164742.GA5780@cadcamlab.org> <20020809041543.GA4818@cadcamlab.org> <3D53D50D.7FA48644@alphalink.com.au> <20020809161046.GB687@cadcamlab.org> <3D579629.32732A73@alphalink.com.au> <20020812154721.GA761@cadcamlab.org> <3D587BA7.1D640926@alphalink.com.au> <20020813180415.B1357@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020813180415.B1357@mars.ravnborg.org>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Sam Ravnborg]
> How about extending the language (side effect) to automagically
> append (EXPERIMENTAL) or (OBSOLETE) to the menu line, if dependent
> on those special tags?

I've thought about that too.  Menuconfig already has magic code to
append ' (NEW)' if it hasn't seen a symbol before.

Your proposed change, however, cannot be easily parsed until we make
'$' optional (and deprecated) in dep_* tags.  The existing Configure
and Menuconfig borrow the /bin/sh parser which, if allowed to see
"$CONFIG_EXPERIMENTAL", will expand it too early to be of use.

Peter
