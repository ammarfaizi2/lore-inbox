Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268036AbUJLWgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268036AbUJLWgK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 18:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267988AbUJLWgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 18:36:10 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:26344 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S268036AbUJLWft
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 18:35:49 -0400
From: David Brownell <david-b@pacbell.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Totally broken PCI PM calls
Date: Tue, 12 Oct 2004 15:35:09 -0700
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@ucw.cz>, ncunningham@linuxmail.org,
       Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <1097455528.25489.9.camel@gaston> <200410121152.53140.david-b@pacbell.net> <1097619180.908.6.camel@gaston>
In-Reply-To: <1097619180.908.6.camel@gaston>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200410121535.09543.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 October 2004 3:13 pm, Benjamin Herrenschmidt wrote:
> On Wed, 2004-10-13 at 04:52, David Brownell wrote:
> 
> > Drivers that don't reset the controller in resume()
> > will need special handling for those BIOS cases.
> > That means USB HCDs, and maybe not a lot else
> > yet in Linux.
> 
> Usually, at least for OHCI, you can read the controller
> status and know if it got reset or is still in suspend state,
> at least that how we did so far (and how apple does as well
> afaik) and seems to work.

Either of those cases have been handled OK for ages;
but the MM tree has OHCI code that also knows about
some (I hope all!) of the "new" BIOS states.


> I don't know about EHCI. 

It's on my list to find out ... :)  One part of it should be
as simple OHCI states. 

- Dave


> Ben.
> 
> 
