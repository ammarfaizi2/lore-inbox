Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319269AbSH2Qpv>; Thu, 29 Aug 2002 12:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319265AbSH2Qpv>; Thu, 29 Aug 2002 12:45:51 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44298 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319269AbSH2Qpu>; Thu, 29 Aug 2002 12:45:50 -0400
Date: Thu, 29 Aug 2002 09:56:44 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jakub Jelinek <jakub@redhat.com>
cc: Rusty Russell <rusty@rustcorp.com.au>, Daniel Jacobowitz <dan@debian.org>,
       <junkio@cox.net>, <linux-kernel@vger.kernel.org>,
       Keith Owens <kaos@ocs.com.au>, <geert@linux-m68k.org>,
       <schwidefsky@de.ibm.com>
Subject: Re: [TRIVIAL] strlen("literal string") -> (sizeof("literal string")-1)
In-Reply-To: <20020829031008.T7920@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0208290955280.2070-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Aug 2002, Jakub Jelinek wrote:
> 
> Well, IMHO at least for the more recent GCC versions kernel
> should leave the job to GCC (ie. either just prototype str* functions,
> or define them to __builtin_str* variants).

I agree. That x86 strlen() inline is from 1991 with fixes ever after, and 
pre-dates gcc having any support for inline at all. We're much more likely 
to be better off just removing it these days. Is somebody willing to 
compare code quality? I wouldn't be in the least surprised if gcc did a 
better job these days..

		Linus

