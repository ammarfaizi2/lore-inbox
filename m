Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161192AbWGIWT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161192AbWGIWT2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 18:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161193AbWGIWT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 18:19:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:11036 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161192AbWGIWT1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 18:19:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=gnZc3pYZL009zFS8opWu/35InyK09LVhkLUnIFDdKPEuDFmciA/mdnAFGPlEx6t9ElTfU8nnxS68d9Di535hznBmzOt1YfLZQQhEw0a9I+jnKRRouNukcf7ZSa88Af1uBPvGiXRBcZYpj4p4QEZWAzWAT+Q4n/BBFm9xQHdaOqo=
Date: Mon, 10 Jul 2006 00:19:19 +0200
From: Diego Calleja <diegocg@gmail.com>
To: "Daniel Bonekeeper" <thehazard@gmail.com>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: Automatic Kernel Bug Report
Message-Id: <20060710001919.d5f9f833.diegocg@gmail.com>
In-Reply-To: <e1e1d5f40607091337g12089f22pe1e675ebc6b65132@mail.gmail.com>
References: <e1e1d5f40607090145k365c0009ia3448d71290154c@mail.gmail.com>
	<6bffcb0e0607090245t2dbcd394n86ce91eec661f215@mail.gmail.com>
	<e1e1d5f40607090329i25f6b1b2s3db2c2001230932c@mail.gmail.com>
	<20060709125805.GF13938@stusta.de>
	<e1e1d5f40607091146s2f8e6431v33923f38c6d10539@mail.gmail.com>
	<20060709191107.GN13938@stusta.de>
	<e1e1d5f40607091301j723b92bje147932a4395775c@mail.gmail.com>
	<20060709222401.52168a58.diegocg@gmail.com>
	<e1e1d5f40607091337g12089f22pe1e675ebc6b65132@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sun, 9 Jul 2006 16:37:46 -0400,
"Daniel Bonekeeper" <thehazard@gmail.com> escribió:


> preempt tasks. If we can keep track of the timestamp of the last time
> the schedule ran, and we see that it was like 5 or 10 seconds ago, it
> means that something is very wrong on the kernel side. We may have
> several levels of fucked-up-ness in which, at a certain level,
> interrupts are still called (and we can call our code here to check
> the sanity of the system). If we see that we didn't schedule for a
> long time, we can trigger the report system (then again, ideally we

That's what NMIs are for

Note that while I like the idea of automatically reporting such bugs
I fully agree with Adrian that it's not a critical issue right now.
It's not that kernel developers are sleeping while users hit tons
of bugs that won't get reported, right now we've _too many_ bug 
reports and developers are not fixing/noticing them as fast as they
get reported. Take a look at kernel.org's bugzilla, and at the kernel
component of fedora/ubuntu/debian/gentoo bugzillas. We're not 
lacking bug reports, quite the contrary: We're getting so many
that some people is starting to question (again) if the current
development model is the right one and whether we should make
a bug-fix-only release.

In fact, one of the main problems is that there's not an "official"
bug reporting tool beyond email. Many kernel developers didn't
like bugzilla when it was started, and as for today, many core 
kernel developers still do not even _look_ at bugzilla.kernel.org.
The hard work of akpm and some cool people like the acpi guys has
made possible lately to start using bugzilla as a sort of
"official" bugzilla, but there're still many kernel developers
that need to be convinced (and many bugzilla features that need
to be polished). AFAIK, people is going to talk seriusly about 
this in OLS.
