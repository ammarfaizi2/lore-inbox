Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290417AbSA3SmJ>; Wed, 30 Jan 2002 13:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290376AbSA3SlA>; Wed, 30 Jan 2002 13:41:00 -0500
Received: from mustard.heime.net ([194.234.65.222]:28389 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S290434AbSA3SjJ>; Wed, 30 Jan 2002 13:39:09 -0500
Date: Wed, 30 Jan 2002 19:38:58 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        Knut Olav Boehmer <knuto@linpro.no>,
        Frank Ronny Larsen <gobo@gimle.nu>
Subject: Re: still problems with heavy i/o load
In-Reply-To: <20020130183719.GA24132@holomorphy.com>
Message-ID: <Pine.LNX.4.30.0201301937080.32276-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is very strange. Is the client machine constant? What kernel does
> it use? Is it reproducible against multiple client kernels? This sounds
> like a fairly serious regression. Are you always using tux as the httpd?
> What about other httpd's?

It's not related to the client at all. It's reproducable with

dd if=file00 of=/dev/null &
dd if=file01 of=/dev/null &
dd if=file02 of=/dev/null &
dd if=file03 of=/dev/null &
dd if=file04 of=/dev/null &
.
.
.
dd if=file99 of=/dev/null &


It's reproducable on all 2.4.x I've tried. That is - with slight
differences
>
> On Wed, Jan 30, 2002 at 06:42:38PM +0100, Roy Sigurd Karlsbakk wrote:
> > strangely, rmap11c seems to be quite stable, but only gives me ~32MB/s,
> > whereas the initial is close to 50.
> > I have posted mesages about this bug so many times now, that I really soon
> > will try to install CP/M or something. At least a stable system!
> > And - yes! - I have tried Andrea's patches. The only fscking thing that
> > seems to be close to solving it is rmap11c
> > Please help me about this
>
> I will at least attempt to reproduce this behavior. I'm suspicious that
> the problem could lie in a dark corner only tangentially VM-related, as
> you seem to be able to reproduce it under a variety of VM's.
>
>
> Cheers,
> Bill
>

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

