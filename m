Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266588AbRGLU6p>; Thu, 12 Jul 2001 16:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266587AbRGLU6e>; Thu, 12 Jul 2001 16:58:34 -0400
Received: from [194.213.32.142] ([194.213.32.142]:23812 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S266582AbRGLU60>;
	Thu, 12 Jul 2001 16:58:26 -0400
Date: Mon, 9 Jul 2001 12:17:38 +0000
From: Pavel Machek <pavel@suse.cz>
To: Dan Maas <dmaas@dcine.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
Subject: Re: VM Requirement Document - v0.0
Message-ID: <20010709121736.B39@toy.ucw.cz>
In-Reply-To: <fa.jprli0v.qlofoc@ifi.uio.no> <fa.e66agbv.hn0u1v@ifi.uio.no> <002501c104f4/mnt/sendme701a8c0@morph>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <002501c104f4/mnt/sendme701a8c0@morph>; from dmaas@dcine.com on Wed, Jul 04, 2001 at 09:49:43PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Getting the user's "interactive" programs loaded back
> > in afterwards is a separate, much more difficult problem
> > IMHO, but no doubt still has a reasonable solution.
> 
> Possibly stupid suggestion... Maybe the interactive/GUI programs should wake
> up once in a while and touch a couple of their pages? Go too far with this
> and you'll just get in the way of performance, but I don't think it would
> hurt to have processes waking up every couple of minutes and touching glibc,
> libqt, libgtk, etc so they stay hot in memory... A very slow incremental
> "caress" of the address space could eliminate the
> "I-just-logged-in-this-morning-and-dammit-everything-has-been-paged-out"
> problem.

Ugh... Ouch.... Ugly, indeed.

What you might want to do is 

while true; do 
cat /usr/lib/libc* > /dev/null; sleep 1m
cat /usr/lib/qt* > /dev/null; sleep 1m
...
done

running on your system...

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

