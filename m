Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319266AbSHWTuc>; Fri, 23 Aug 2002 15:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319217AbSHWTtf>; Fri, 23 Aug 2002 15:49:35 -0400
Received: from [195.39.17.254] ([195.39.17.254]:24448 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S319242AbSHWTtR>;
	Fri, 23 Aug 2002 15:49:17 -0400
Date: Fri, 2 Nov 2001 10:05:25 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Theodore Ts'o" <tytso@mit.edu>, Oliver Xymoron <oxymoron@waste.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20011102100525.Y35@toy.ucw.cz>
References: <20020818021522.GA21643@waste.org> <20020819054359.GB26519@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020819054359.GB26519@think.thunk.org>; from tytso@mit.edu on Mon, Aug 19, 2002 at 01:43:59AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  What entropy can be measured from disk timings are very often leaked
> >  by immediately relaying data to web, shell, or X clients.  Further,
> >  patterns of drive head movement can be remotely controlled by clients
> >  talking to file and web servers. Thus, while disk timing might be an
> >  attractive source of entropy, it can't be used in a typical server
> >  environment without great caution.
> 
> This is something to be concerned about, to be sure.  But generally a
> client won't have complete control of the drive head movement ---
> there are other clients involved --- and the adversary generally won't
> have complete knowledge of the block allocation of files, for example,
> so he/she would not be able to characterize the disk drive timings to
> the degree of accuracy required.

You seem  assume that adversary is on remote system. That's not neccessarily
the case.

Imagine you wanting to generate gpg key while I have normal user account
on the machine. I can sample /proc/interrupts, measure disk speeds etc...
Perhaps we are alone on [otherwise idle] machine. You still don't want me 
to guess your key.

								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

