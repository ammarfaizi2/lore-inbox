Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318033AbSGWLn6>; Tue, 23 Jul 2002 07:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318034AbSGWLn5>; Tue, 23 Jul 2002 07:43:57 -0400
Received: from unthought.net ([212.97.129.24]:59275 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S318033AbSGWLny>;
	Tue, 23 Jul 2002 07:43:54 -0400
Date: Tue, 23 Jul 2002 13:47:03 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: type safe(r) list_entry repacement: generic_out_cast
Message-ID: <20020723114703.GM11081@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
References: <15677.15834.295020.89244@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15677.15834.295020.89244@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 09:28:26PM +1000, Neil Brown wrote:
> 
...
> Why "out_cast"???
> 
> Well OO people would probably call it a "down cast" as you are
> effectively casting from a more-general type to a less-general (more
> specific) type that is there-fore lower on the type latice.
> So maybe it should be "generic_down_cast".
> But seeing that one is casting from an embeded internal structure to a
> containing external structure, "out_cast" seemed a little easier to
> intuitively understand.

This is one of the type issues that C++ would solve nicely - not because
of OO, but because of parameterized types.  Completely removing the need
to do any kind of casting (in this situation), and allowing the compiler
to inline based on the actual use of types in each specific
instantiation of a function such as a list utility funciton.  Type safe
code that runs faster, yay!.

Yes, I know, it doesn't help us one bit here, because they'll be selling
snow-cones in hell before the kernel is rewritten in C++.  And there are
many good reasons why it is like that.

I'm happy to see someone taking an initiative to improve type safety (as
much as the language allows).  And the above was just pointed out
because of the occational "why not C++" versus "no OO sucks" (as if C++
was just OO) debates.

Cheers,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
