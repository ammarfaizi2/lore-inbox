Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261943AbSJIR57>; Wed, 9 Oct 2002 13:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261936AbSJIR4t>; Wed, 9 Oct 2002 13:56:49 -0400
Received: from nameservices.net ([208.234.25.16]:62909 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S261914AbSJIR4C>;
	Wed, 9 Oct 2002 13:56:02 -0400
Message-ID: <3DA46FFF.2A0347C5@opersys.com>
Date: Wed, 09 Oct 2002 14:05:51 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Yumiko Sugita <sugita@sdl.hitachi.co.jp>
CC: robert@schwebel.de, lkst-develop@lists.sourceforge.jp,
       linux-kernel@vger.kernel.org, LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [Lkst-develop] Re: Release of LKST 1.3
References: <5.0.2.6.2.20020918210036.05287a40@sdl99c>
	 <5.0.2.6.2.20020918210036.05287a40@sdl99c>
	 <5.0.2.6.2.20020926182552.0506a898@sdl99c> <5.0.2.6.2.20021003183537.06a8ad90@sdl99c>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


... sorry for the delay, I'm very busy lately ...

Yumiko Sugita wrote:
>   We think callback feature is useful for kernel developers.
> Are there any problems?　Are you going to remove callbacks
> from LTT?  Is the main reason security?  If you have some
> cases of security problems about callbacks, please teach
> them and give some advice to us.

The issue of callbacks was covered by one of Ingo's comments about
LTT. Here's the excerpt from his mail:
> okay. The thing is that generic callbacks and data hooks in the task
> structure are an invitation for various types of abuses - security and GPL
> type abuses. People do get very nervous when seeing such stuff - eg. read
> back Christoph Hellwig's comment from a few weeks ago. It's a red flag for
> many people. Provide a clean and concentrated set of APIs, no callbacks,
> no unnecessery hooks. I can see the technical reasons why you have added
> it - it's in theory an extensible interface, but generally we tend to add
> such stuff when it's needed - if it's needed at all.

(You can get the complete copy from:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103276662708853&w=2)

If you would like to provide callbacks for _kernel developers_ then
these callbacks should live as an outside patch, as with any other
facility that is useful to kernel development only.

If there is a legitimate need for such hooks later on, then we can
add them when needed, as Ingo suggested. None of it is really
complicated. These callbacks would also have to be exported as
GPL-only, in order to avoid any sort of abuse. The main issue we are
concentrating on at this time, however, is to make sure that the core
infrastructure is lightweight and solid. Any additional features will
be added on top of this core infrastructure.

>   After future, we'll join community actively. We'll use LTT
> and want to concern LTT, so we'll join the discussion of you
> and other LTT developers about Linux RAS.
>   We hope to co-operate you and other developers about
> Linux RAS.

We certainly welcome any contribution and will be happy to help
you integrate your features into a common tracing infrastructure.
Feel free to join in the discussion around the LTT development
mailing list (See the project's web site for details on how to
subscribe).

Best regards,

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
