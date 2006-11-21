Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161363AbWKUXH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161363AbWKUXH5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 18:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161413AbWKUXH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 18:07:57 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23174 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161363AbWKUXH4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 18:07:56 -0500
Date: Wed, 22 Nov 2006 00:07:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tejun Heo <htejun@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: SATA powersave patches
Message-ID: <20061121230744.GD1995@elf.ucw.cz>
References: <20060908123537.GB17640@elf.ucw.cz> <4501655F.5000103@gmail.com> <20060910224815.GC1691@elf.ucw.cz> <4505394F.6060806@gmail.com> <20060918100548.GJ3746@elf.ucw.cz> <450E771E.1070207@gmail.com> <20061106135751.GA13517@elf.ucw.cz> <454F747A.9050209@gmail.com> <20061112183927.GB5081@ucw.cz> <456280FE.70607@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456280FE.70607@gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>If I understood correctly, the high power consumption of 
> >>ahci controller can be solved by dynamically turning off 
> >>command processing while the controller is idle, which 
> >>fits nicely into link powersaving, right?  So, I think 
> >>full-fledged leveled dynamic PM would be an overkill for 
> >>this particular problem, but then again, maybe the 
> >
> >It is single bit, and it should not even need a timeout, AFAICT, so
> >perhaps we should just fix it (no need for dynamic PM layers). It
> >probably does not even need to be configurable...
> 
> I think this has been discussed in linux-ide recently but just to add my 
> 2 cents.  ALPE and ASP can cause quite some problems.  Many devices 
> don't implement link powermanagement mode properly and some locks up 

Ok, so it needs to be optional :-). I played with the code a little
bit, but did not find combination that both worked and saved power :-(.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
