Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262650AbVGHM66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbVGHM66 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 08:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262649AbVGHM66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 08:58:58 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:29568 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262647AbVGHM64
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 08:58:56 -0400
References: <1120816072.30164.10.camel@localhost>
            <1120816229.30164.13.camel@localhost>
            <1120817463.30164.43.camel@localhost>
            <84144f0205070804171d7c9726@mail.gmail.com>
            <Pine.LNX.4.61.0507081412280.3743@scrub.home>
            <courier.42CE70EE.000029AA@courier.cs.helsinki.fi>
            <Pine.LNX.4.61.0507081441440.3728@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0507081441440.3728@scrub.home>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ram <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>, mike@waychison.com, bfields@fieldses.org,
       Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: share/private/slave a subtree
Date: Fri, 08 Jul 2005 15:58:55 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42CE788F.00003AE7@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jul 2005, Pekka J Enberg wrote:
> > Hey, I just review patches. I don't get to set requirements. There's a reason
> > why enums are preferred though. They define a proper name for the constant.

Roman Zippel writes:
> Who prefers that?

Well, me, at least. I can't speak for others. 

On Fri, 8 Jul 2005, Pekka J Enberg wrote:
> > It's far to easy to mess up with #defines.

Roman Zippel writes:
> Rather unlikely with such simple masks.

Redefining a constant with #define by an accident is easy. Introducing 
duplicate constants is equally easy (see radeon headers for an example). 

On Fri, 8 Jul 2005, Pekka J Enberg wrote:
> > They also document the code intent
> > much better as you can group related constants together.

Roman Zippel writes:
> You can't do that with defines?

Sure you can but have you ever tried to figure out where a group of #define 
enumerations end? Enums are a natural language construct for grouping 
related constants so why not use it? 

Bottom line, there are few advantages to using enums rather than #defines 
which is why they are IMHO preferred for new code. 

                    Pekka 

