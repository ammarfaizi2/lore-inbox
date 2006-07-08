Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWGHLYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWGHLYO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 07:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWGHLYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 07:24:14 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11951 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964790AbWGHLYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 07:24:13 -0400
Date: Sat, 8 Jul 2006 13:23:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Bill Davidsen <davidsen@tmr.com>, Benny Amorsen <benny+usenet@amorsen.dk>,
       linux-kernel@vger.kernel.org
Subject: Re: ext4 features
Message-ID: <20060708112356.GL1700@elf.ucw.cz>
References: <44A9904F.7060207@wolfmountaingroup.com> <20060703232547.2d54ab9b.diegocg@gmail.com> <m3r711u3yk.fsf@ursa.amorsen.dk> <44AB3E4C.2000407@tmr.com> <20060707141030.GC4239@ucw.cz> <m38xn58g26.fsf@defiant.localdomain> <20060707213030.GA5393@ucw.cz> <m3odw0e5cu.fsf@defiant.localdomain> <20060708105532.GH1700@elf.ucw.cz> <m364i8e42v.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m364i8e42v.fsf@defiant.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2006-07-08 13:19:52, Krzysztof Halasa wrote:
> Pavel Machek <pavel@ucw.cz> writes:
> 
> > Why not? You use libextfs or how is it called to read the file from
> > the disk directly (read-only access), then you write it back using
> > regular calls.
> >
> > Of course, you can end up with "deleted" data being corrupted if
> > kernel reused the area before undelete, or while you were doing
> > undelete... but that's expected. They were _deleted_, right?
> 
> What if the "undeleted" file contained /etc/shadow because someone
> was changing password at the time? :-)

Well, that's okay :-).
								Pavel


























...of course, undelete is root-only operation, and one that should not
be taken lightly. You need to verify you got what you wanted at the end.
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
