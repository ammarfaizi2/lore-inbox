Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbSKNTUG>; Thu, 14 Nov 2002 14:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262800AbSKNTUF>; Thu, 14 Nov 2002 14:20:05 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:13833 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S262380AbSKNTUE>;
	Thu, 14 Nov 2002 14:20:04 -0500
Date: Thu, 14 Nov 2002 20:26:45 +0100
From: Willy Tarreau <willy@w.ods.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Thorsten Mika <tmika@t-online.de>, "Randy.Dunlap" <rddunlap@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: system lockups and shutdowns fo running processes
Message-ID: <20021114192645.GA553@alpha.home.local>
References: <20021114180807.20f1578f.tmika@t-online.de> <Pine.LNX.3.95.1021114132125.13043A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1021114132125.13043A-100000@chaos.analogic.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

On Thu, Nov 14, 2002 at 01:27:50PM -0500, Richard B. Johnson wrote:
> On Thu, 14 Nov 2002, Thorsten Mika wrote:
> > Call Trace: [<c012f5b4>] [<c0131c47>] [<c0131eb5>] [<c010546c>]
> > Code: 07 20 07 20 07 20 07 20 07 20 07 20 07 20 07 20 07 20 07 20
> Yawn.  It's trying to execute data...
> <TAB><SPC><TAB><SPC><TAB><SPC>..........
> Possible stack overflow.
 
It's not <TAB> <SPC>, it's a copy from a text video memory buffer of an empty
portion of the screen. 07 is the attribute (=color), and 20 the <SPC> which
fills empty space. So this does not look like a buffer overflow, but a use of
a bad pointer somewhere. Perhaps a race during a text scroll or something ?

BTW, <TAB> is 9 :-)

Cheers,
Willy

