Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267260AbTAUWxw>; Tue, 21 Jan 2003 17:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267263AbTAUWxw>; Tue, 21 Jan 2003 17:53:52 -0500
Received: from dhcp34.trinity.linux.conf.au ([130.95.169.34]:10112 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S267260AbTAUWxv>; Tue, 21 Jan 2003 17:53:51 -0500
Subject: Re: [patch] IDE OnTrack remap for 2.5.58
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andries.Brouwer@cwi.nl
Cc: jim.houston@attbi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <UTC200301211108.h0LB8Ad12683.aeb@smtp.cwi.nl>
References: <UTC200301211108.h0LB8Ad12683.aeb@smtp.cwi.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043190115.1384.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 21 Jan 2003 23:01:56 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-21 at 11:08, Andries.Brouwer@cwi.nl wrote:
>     On Thu, 2003-01-16 at 18:14, Jim Houston wrote:
>     > I went back and looked through the patches and found that the remapping
>     > support was removed in patch-2.5.30.  The comments in the mailing list
>     > suggest that it belonged in user space.
> 
> [of course a shift cannot be done in user space]

Maybe it can. One reason ide/raid/*.c isnt in 2.5 is that I hope we can
use the device mapper to remove the entire chunk of code for these. dm
may also be sufficient to do the block shift.

> I think both Andre and Martin were happy, but maybe you mean nobody
> asked you? Are you unhappy with this change? And if so, why?

By volume of mail I get about it. I hadn't realised just how common
DM was. I'd prefer to make device mapper do it though.

