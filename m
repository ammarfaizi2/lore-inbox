Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263622AbTL2QNm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 11:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbTL2QNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 11:13:41 -0500
Received: from mta01.mail.tds.net ([216.170.230.81]:38375 "EHLO
	mta01.mail.tds.net") by vger.kernel.org with ESMTP id S263622AbTL2QNg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 11:13:36 -0500
Date: Mon, 29 Dec 2003 10:13:33 -0600 (CST)
From: David Lloyd <dmlloyd@tds.net>
To: Andy Isaacson <adi@hexapodia.org>
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 Heads-up
In-Reply-To: <20031226005840.A30827@hexapodia.org>
Message-ID: <Pine.LNX.4.58.0312291013120.4466@tomservo.workpc.tds.net>
References: <1072403207.17036.37.camel@clubneon.clubneon.com>
 <bsgav5$4qh$1@cesium.transmeta.com> <Pine.LNX.4.58.0312252021540.14874@home.osdl.org>
 <20031226005840.A30827@hexapodia.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Dec 2003, Andy Isaacson wrote:

> On Thu, Dec 25, 2003 at 08:34:33PM -0800, Linus Torvalds wrote:
> > The cast/conditional expression as lvalue are _particularly_ ugly 
> > extensions, since there is absolutely zero point to them. They are very 
> > much against what C is all about, and writing something like this:
> > 
> > 	a ? b : c = d;
> > 
> > is something that only a high-level language person could have come up 
> > with. The _real_ way to do this in C is to just do
> > 
> > 	*(a ? &b : &c) = d;
> > 
> > which is portable C, does the same thing, and has no strange semantics.
> 
> But doesn't the first one potentially let the compiler avoid spilling to
> memory, if b and c are both in registers?

I can't imagine anything wrong with:

if (a) b = d else c = d;

- D
