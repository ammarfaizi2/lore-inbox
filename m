Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbUL3Cm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbUL3Cm2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 21:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbUL3Cm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 21:42:28 -0500
Received: from 80-219-198-150.dclient.hispeed.ch ([80.219.198.150]:11392 "EHLO
	xbox.hb9jnx.ampr.org") by vger.kernel.org with ESMTP
	id S261517AbUL3CmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 21:42:25 -0500
Subject: Re: ptrace single-stepping change breaks Wine
From: Thomas Sailer <sailer@scs.ch>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jesse Allen <the3dfxdude@gmail.com>, Mike Hearn <mh@codeweavers.com>,
       Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       wine-devel <wine-devel@winehq.com>
In-Reply-To: <Pine.LNX.4.58.0412291807440.2353@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	 <20041119212327.GA8121@nevyn.them.org>
	 <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org>
	 <20041120214915.GA6100@tesore.ph.cox.net> <41A251A6.2030205@wanadoo.fr>
	 <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>
	 <1101161953.13273.7.camel@littlegreen>
	 <1104286459.7640.54.camel@gamecube.scs.ch>
	 <1104332559.3393.16.camel@littlegreen>
	 <1104348944.5645.2.camel@kronenbourg.scs.ch>
	 <5304685704122912132e3f7f76@mail.gmail.com>
	 <1104371395.5128.2.camel@gamecube.scs.ch>
	 <Pine.LNX.4.58.0412291807440.2353@ppc970.osdl.org>
Content-Type: text/plain
Organization: Supercomputing Systems AG
Date: Thu, 30 Dec 2004 03:39:50 +0100
Message-Id: <1104374390.5128.8.camel@gamecube.scs.ch>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-29 at 18:10 -0800, Linus Torvalds wrote:

> I have no idea what "seh" is in wine-speak, but it appears that your 

seh means structured exception handling in microsoft-speak.

http://msdn.microsoft.com/library/default.asp?url=/library/en-us/debug/base/structured_exception_handling.asp
http://www.jorgon.freeserve.co.uk/ExceptFrame.htm

> Some wine person would need to inform us about what the seh exception 
> thing means.. "code c0000005"? 

c0000005 apparently means memory access violation. Looks like xst is
getting confused about its memory allocations...

Tom


