Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWEWAaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWEWAaJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 20:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWEWAaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 20:30:09 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:54928 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751009AbWEWAaH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 20:30:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e8L87qnTwrLr/Nb+tIQdr8d2E5/GegBGU5xZihlfSpHB7ZZRAvxmnlqffX/eoKeRqUuEYNtyju2Y+Brb/do66eUrHispquRVEP5DP3jK0VJmuZFS7GH1iKUZo+Vq/haUozWRydiYQ2M8BeQC13cdlq9gPLGfnZsy3qKOnlXMzNg=
Message-ID: <5bdc1c8b0605221730t2bf43ab8j1ec3ebd98a4e459e@mail.gmail.com>
Date: Mon, 22 May 2006 17:30:06 -0700
From: "Mark Knecht" <markknecht@gmail.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Subject: Re: 2.6.16-rt22/23 kernels hanging after registering IO schedulers
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Ingo Molnar" <mingo@elte.hu>, "Clark Williams" <williams@redhat.com>,
       "Robert Crocombe" <rwcrocombe@raytheon.com>
In-Reply-To: <1148333237.4997.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0605191022l7114707fjd6b3cdcfe68b97c7@mail.gmail.com>
	 <Pine.LNX.4.58.0605211321400.28717@gandalf.stny.rr.com>
	 <5bdc1c8b0605211410ld978047x3c4ad37ec79f5e8c@mail.gmail.com>
	 <1148333237.4997.7.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/06, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Sun, 2006-05-21 at 14:10 -0700, Mark Knecht wrote:
>
> > Hi Steve,
> >    It's good to hear from you and great if you can take a look at
> > this. I did some more ground work and now feel bad that I didn't
> > report back much earlier. It appears that the problems have started
> > with the very first revision of 2.6.16-rt support. I am currently
> > writing you from 2.6.16 from kernel.org which booted fine. However
> > 2.6.16-rt1 fails the same way as all the later kernels that I tried
> > with a hang right after registering the schedulers.
>
> You're getting farther than I am.  My system crashes in init_8259A right
> in the unlocking of the i8259A_lock.  It takes an exception in the
> local_irq_restore of the raw_spin_unlock_irqrestore.  I tried unlocking
> the lock and locking it again at the beginning of the function, and that
> seems to work fine.  But this function didn't change between the
> previous versions that do work.  So I think something is very wacky
> going on someplace else.
>
> Unfortunately, I'm very behind in the work that I get paid for, so I
> really don't have any more time to look into this.  Especially since my
> main developing machine happens to be my x86_64.
>
> Hopefully, Ingo can find something, or I catch up and can work on this
> again.
>
> -- Steve
>
<SNIP>

Steve,
   Hi. Hey, I'm happy to even get a response! Don't worry at all about
not being able to work on it right now. I completely understand. I'm
sure Ingo will pop up one of these days soon and we'll get all this
ironed out.

   In the meantime I'm looking into redoing the config file from
scratch tonight to see if something has cropped up using make
oldconfig. I've not had problems with that myself but I have read
reports on the web that others have.

   I'll let you all know if I find any new results.

Cheers,
Mark
