Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262863AbUCWVuV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 16:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbUCWVuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 16:50:20 -0500
Received: from gprs214-90.eurotel.cz ([160.218.214.90]:35712 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262882AbUCWVsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 16:48:47 -0500
Date: Tue, 23 Mar 2004 22:47:34 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jonathan Sambrook <swsusp@hmmn.org>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]
Message-ID: <20040323214734.GD364@elf.ucw.cz>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au> <20040318193703.4c02f7f5.akpm@osdl.org> <1079661410.15557.38.camel@calvin.wpcb.org.au> <20040318200513.287ebcf0.akpm@osdl.org> <1079664318.15559.41.camel@calvin.wpcb.org.au> <20040321220050.GA14433@elf.ucw.cz> <1079988938.2779.18.camel@calvin.wpcb.org.au> <20040322231737.GA9125@elf.ucw.cz> <20040323095318.GB20026@hmmn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323095318.GB20026@hmmn.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Now I have _proof_ that eye-candy is harmfull. What is see on screen is:
> > > 
> > > No, that's not proof; just a bug in the code. It's not using the right
> > > code to display the error message. I'll fix it asap.
> > 
> > :-)
> > 
> > I'd really like eye-candy code to be gone. Its long, and its not worth
> > the trouble.
> 
> Pejorative comments aside Pavel, it is valued feedback for end-user
> re-assurance. It has also helped swsusp2 get streets ahead of the other
> implementations by aiding end-user feedback on a wide range of hardware,
> Which would appear to be well worth it? If it's not broke (and is
> valuble) why rip it out?

Its 1000 lines. If it is not broken now, it will be broken in 2.8, and
because it is in mainline, it will be up to linus to fix it.

Oh and it is enough confusing that it confuses me. Some messages end
in dmesg, some do not. User feedback can be done with much less code,
and also slightly less confusing for the user, see swsusp1. [We have
to switch to another console, anyway; and printing dots is easy.]

Okay, we should probably make suspend more quiet, I can see users
badly confused by those hdX: spinning down (etc) messages.

Also, in your model, where do messages printk()-ed from drivers during
suspend/resume end up? Corrupting screen? Lost from sight and only
accessible from dmesg? I believe driver messages *are* important, and
do not see how they could coexist with eye-candy.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
