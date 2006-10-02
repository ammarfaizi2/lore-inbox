Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbWJBQkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbWJBQkx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 12:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbWJBQkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 12:40:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47810 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965039AbWJBQkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 12:40:52 -0400
Date: Mon, 2 Oct 2006 09:40:42 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
cc: Lee Revell <rlrevell@joe-job.com>, Matti Aarnio <matti.aarnio@zmailer.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Spam, bogofilter, etc
In-Reply-To: <45212F39.5000307@mbligh.org>
Message-ID: <Pine.LNX.4.64.0610020933020.3952@g5.osdl.org>
References: <1159539793.7086.91.camel@mindpipe>  <20061002100302.GS16047@mea-ext.zmailer.org>
 <1159802486.4067.140.camel@mindpipe> <45212F39.5000307@mbligh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 Oct 2006, Martin J. Bligh wrote:
> 
> If you got rid of "slut" and "schoolgirl" that'd get rid of half of it.

The problem with bogo-filter is that THE WHOLE CONCEPT IS FLAWED.

I'm sorry, but spam-filtering is simply harder than the bayesian 
word-count weenies think it is. I even used to _know_ something about 
bayesian filtering, since it was one of the projects I worked on at uni, 
and dammit, it's not a good approach, as shown by the fact that it's 
trivial to get around.

I don't know why people got so excited about the whole bayesian thing. 
It's fine as _one_ small clause in a bigger framework of deciding spam, 
but it's totally inappropriate for a "yes/no" kind of decision on its own.

If you want a yes/no kind of thing, do it on real hard issues, like not 
accepting email from machines that aren't registered MX gateways. Sure, 
that will mean that people who just set up their local sendmail thing and 
connect directly to port 25 will just not be able to email, but let's face 
it, that's why we have ISP's and DNS in the first place.

But don't do it purely on some bogus word analysis.

If you want to do word analysis, use it like SpamAssassin does it - with 
some Bayesian rule perhaps adding a few points to the score. That's 
entirely appropriate. But running bogo-filter _instead_ of spamassassin is 
just asinine.

			Linus
