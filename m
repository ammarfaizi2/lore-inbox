Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268915AbSIRVmY>; Wed, 18 Sep 2002 17:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268926AbSIRVmY>; Wed, 18 Sep 2002 17:42:24 -0400
Received: from users.linvision.com ([62.58.92.114]:21623 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S268915AbSIRVmX>; Wed, 18 Sep 2002 17:42:23 -0400
Date: Wed, 18 Sep 2002 23:46:37 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       Ingo Molnar <mingo@elte.hu>, William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020918234637.A29270@bitwizard.nl>
References: <Pine.LNX.4.44L.0209181330580.1519-100000@duckman.distro.conectiva> <Pine.LNX.4.44.0209180938590.1913-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209180938590.1913-100000@home.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 09:48:24AM -0700, Linus Torvalds wrote:
> 
> > On Wed, 18 Sep 2002, Linus Torvalds wrote:
> > 
> > > I would suggest something like this:
> > >  - make pid_max start out at 32k or whatever, to make "ps" look nice if
> > >    nothing else.
> > >  - every time we have _any_ trouble at all with looking up a new pid, we
> > >    double pid_max.
> > 
> > > +		if (nr_threads > pid_max >> 4)

> The people who care about ps being pretty will probably never see more 
> than 5 digits.

Agreed. While on the topic of number of digits: If this is in place
we could easily start out pid_max at say 9999, fitting the pids in
one less digit than we normally do now. 

(I've always thought we should have sticked with pid_max at the
traditional Unix value of 32000, and not 32767).

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currenly in such an       * 
* excursion: The stable situation does not include humans. ***************
