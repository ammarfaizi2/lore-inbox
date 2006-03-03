Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWCCVbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWCCVbx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 16:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWCCVbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 16:31:53 -0500
Received: from smtp101.rog.mail.re2.yahoo.com ([206.190.36.79]:55724 "HELO
	smtp101.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751313AbWCCVbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 16:31:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=hzTHsf8uP4cgSkb6kqbN72mwZvc/jfC83lA0M6OMmZg1k6RA0CMtDgyKJ815K4l7LBq0l4mKLN0DN1FCArlGKTMOvB4PMndPZyj2ge0nPViTSmMnPMscwUsaNIUhSMvFQ/kSy4l8rFT2ovU11TN8LPFZjBgX189eJHVsGGDFLak=  ;
Subject: Re: [2.6 patch] make UNIX a bool
From: "James C. Georgas" <jgeorgas@rogers.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
In-Reply-To: <20060302233249.2aa918f4.mrmacman_g4@mac.com>
References: <1141358816.3582.18.camel@Rainsong.home>
	 <1141359278.3582.22.camel@Rainsong.home>
	 <20060302233249.2aa918f4.mrmacman_g4@mac.com>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 16:31:51 -0500
Message-Id: <1141421511.11092.66.camel@Rainsong.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-03 at 23:32 -0500, Kyle Moffett wrote:
> On Thu, 02 Mar 2006 23:14:38 -0500 "James C. Georgas" <jgeorgas@rogers.com> wrote: 
> > On Thu, 2006-02-03 at 21:32 +0100, Adrian Bunk wrote:
> > > We do not have to export symbols we don't want to export to modules but 
> > > needed by CONFIG_UNIX.
> > 
> > Sorry, I must just be dense, or something.
> > 
> > Is not the only difference between a modular driver and a built in
> > driver supposed to be the initialization and cleanup functions?
> > 
> > I don't see why you would have to expose any additional symbols, over
> > and above the existing required symbols, to load your module.
> 
> af_unix (IE: CONFIG_UNIX) currently uses the symbol get_max_files.  It 
> is the only module that uses that symbol, and that symbol probably should 
> not be exported as it's kind of an internal API.  Therefore if we mandate 
> that CONFIG_UNIX != m, then that symbol may be properly unexported and 
> made private, because nothing modular would use it.  Does that clear 
> things up?
> 

Yes, I think I understand.

However, even if you don't export the symbol, I don't see how you can
make it private (i.e. static declaration) to file_table.c, since it has
to remain extern, in order to be visible to af_unix.c.

> P.S.: Please don't remove people from the CC list if you expect them to 
> respond to your message (Adrian Bunk readded to CC).

Whoops. I should've hit "reply to all" instead of just hitting "reply".
Thanks. I also somehow got this post split off from the main thread.
I've been responding there.

> 
> Cheers,
> Kyle Moffett
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
James C. Georgas <jgeorgas@rogers.com>

