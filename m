Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132220AbRDPVVu>; Mon, 16 Apr 2001 17:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132167AbRDPVUY>; Mon, 16 Apr 2001 17:20:24 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:3076 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S132152AbRDPVTU>;
	Mon, 16 Apr 2001 17:19:20 -0400
Date: Mon, 16 Apr 2001 14:33:21 +0000
From: Pavel Machek <pavel@suse.cz>
To: Ulrich Drepper <drepper@cygnus.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: List of all-zero .data variables in linux-2.4.3 available
Message-ID: <20010416143320.A40@(none)>
In-Reply-To: <200104121929.MAA04049@adam.yggdrasil.com> <m33dbdsy8r.fsf@otr.mynet.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <m33dbdsy8r.fsf@otr.mynet.cygnus.com>; from drepper@redhat.com on Thu, Apr 12, 2001 at 12:40:20PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 	I am aware of a couple of cases where code relied on static
> > variables being allocated contiguously, but, in both cases, those
> > variables were either all zeros or all non-zeros, so my proposed
> > change would not break such code.
> 
> Continuous placement is not the only property defined by
> initialization.  There are many more.  You cannot change this since it
> will quite a few programs and libraries and subtle and hard to
> impossible to identify ways.  Simply educate programmers to not
> initialize.

Unless ansiC specifies such behaviour, such code is buggy. And buggy
code should be fixed, not be used as argument against optimalization.
[Of course, you can turn off that optimalization for buggy code, if code
is too ugly to fix.] 

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

