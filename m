Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316437AbSHOBWO>; Wed, 14 Aug 2002 21:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316586AbSHOBWO>; Wed, 14 Aug 2002 21:22:14 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:52218 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316437AbSHOBWN>; Wed, 14 Aug 2002 21:22:13 -0400
Subject: Re: [patch 4/21] fix ARCH_HAS_PREFETCH
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Willy Tarreau <willy@w.ods.org>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3D5AC481.2080505@zytor.com>
References: <3D56B13A.D3F741D1@zip.com.au>
	<Pine.NEB.4.44.0208132322340.1351-100000@mimas.fachschaften.tu-muenchen.de>
	<ajc095$hk1$1@cesium.transmeta.com> <20020814194019.A31761@bitwizard.nl>
	<3D5AB250.3070104@zytor.com> <20020814204556.GA7440@alpha.home.local> 
	<3D5AC481.2080505@zytor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 15 Aug 2002 02:23:54 +0100
Message-Id: <1029374634.28240.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-14 at 21:58, H. Peter Anvin wrote:
> 
> Since some processors now have "busy wait delay" instructions, this
> would also make it possible to do:

Nobody should be using an empty busy loop. If its a short timed busy
loop then they should be using udelay, if its a long one
schedule_timeout()

If its polling hardware then it isnt an empty loop

