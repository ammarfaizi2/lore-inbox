Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319308AbSH2Uew>; Thu, 29 Aug 2002 16:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319336AbSH2Uev>; Thu, 29 Aug 2002 16:34:51 -0400
Received: from 3512-780200-10.dialup.surnet.ru ([212.57.170.10]:48647 "EHLO
	zzz.zzz") by vger.kernel.org with ESMTP id <S319308AbSH2Uev>;
	Thu, 29 Aug 2002 16:34:51 -0400
Date: Fri, 30 Aug 2002 02:38:08 +0600
From: Denis Zaitsev <zzz@cd-club.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jakub Jelinek <jakub@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Daniel Jacobowitz <dan@debian.org>, junkio@cox.net,
       linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>,
       geert@linux-m68k.org, schwidefsky@de.ibm.com
Subject: Re: [TRIVIAL] strlen("literal string") -> (sizeof("literal string")-1)
Message-ID: <20020830023807.A1160@natasha.zzz.zzz>
References: <20020829031008.T7920@devserv.devel.redhat.com> <Pine.LNX.4.44.0208290955280.2070-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208290955280.2070-100000@home.transmeta.com>; from torvalds@transmeta.com on Thu, Aug 29, 2002 at 09:56:44AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 09:56:44AM -0700, Linus Torvalds wrote:
> 
> On Thu, 29 Aug 2002, Jakub Jelinek wrote:
> > 
> > Well, IMHO at least for the more recent GCC versions kernel
> > should leave the job to GCC (ie. either just prototype str* functions,
> > or define them to __builtin_str* variants).
> 
> I agree. That x86 strlen() inline is from 1991 with fixes ever after, and 
> pre-dates gcc having any support for inline at all. We're much more likely 
> to be better off just removing it these days. Is somebody willing to 
> compare code quality? I wouldn't be in the least surprised if gcc did a 
> better job these days..
> 

GCC-3.2 doesn't do any inlining for __builtin_strlen at all, if -mcpu > i386.
It just does call/jump outline strlen...  Isn't very good?
