Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbUL3CLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbUL3CLL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 21:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbUL3CLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 21:11:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:19118 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261509AbUL3CKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 21:10:54 -0500
Date: Wed, 29 Dec 2004 18:10:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Thomas Sailer <sailer@scs.ch>
cc: Jesse Allen <the3dfxdude@gmail.com>, Mike Hearn <mh@codeweavers.com>,
       Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <1104371395.5128.2.camel@gamecube.scs.ch>
Message-ID: <Pine.LNX.4.58.0412291807440.2353@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com> 
 <20041119212327.GA8121@nevyn.them.org>  <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org>
  <20041120214915.GA6100@tesore.ph.cox.net> <41A251A6.2030205@wanadoo.fr> 
 <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>  <1101161953.13273.7.camel@littlegreen>
  <1104286459.7640.54.camel@gamecube.scs.ch>  <1104332559.3393.16.camel@littlegreen>
  <1104348944.5645.2.camel@kronenbourg.scs.ch>  <5304685704122912132e3f7f76@mail.gmail.com>
 <1104371395.5128.2.camel@gamecube.scs.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 Dec 2004, Thomas Sailer wrote:
>
> No joy with
> linux-2.6.10
> patch-2.6.10-ac1
> 01-ptrace-reverse.diff
> sigtrap-reverse.diff
> 
> Below is the seh trace output. In the working case (2.6.8) there is no
> trace:seh: output at this point.

I have no idea what "seh" is in wine-speak, but it appears that your 
problem is something totally different, especially as none of the eflags- 
changes seem to matter for you. Also, in your "seh" exception register 
dump, you don't actually seem to have TF set in %eflags (TF is 0x0100).

Some wine person would need to inform us about what the seh exception 
thing means.. "code c0000005"? 

			Linus
