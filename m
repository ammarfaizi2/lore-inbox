Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbVKPGet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbVKPGet (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 01:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbVKPGet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 01:34:49 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:5363 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751184AbVKPGes convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 01:34:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RoefvIxGT26Mojtl7tgoA+lTBhA0TJwU33w8lna4vWTjnqMYNM8Ng/iOizKIoXR/LaMyGfes1l8TMiDuXMWPznpBBj0lJn829umzE/tLrrb7UZx8flF+LZ+fiGuhCcH/6h7rrrNfAWhnmJkPkCA6di2DMHN2TMMFvevCV3f/NLQ=
Message-ID: <489ecd0c0511152234i1b65bb40uc4a8b6867a3c976@mail.gmail.com>
Date: Wed, 16 Nov 2005 14:34:48 +0800
From: Luke Yang <luke.adi@gmail.com>
To: Paul Jackson <pj@sgi.com>
Subject: Re: ADI Blackfin patch for kernel 2.6.14
Cc: akpm@osdl.org, greg@kroah.com, bunk@stusta.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051115221146.4487657f.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <489ecd0c0511010128x41d39643x37893ad48a8ef42a@mail.gmail.com>
	 <20051101165136.GU8009@stusta.de>
	 <489ecd0c0511012306w434d75fbs90e1969d82a07922@mail.gmail.com>
	 <489ecd0c0511032059n394abbb2s9865c22de9b2c448@mail.gmail.com>
	 <20051104230644.GA20625@kroah.com>
	 <489ecd0c0511062258k4183d206odefd3baa46bb9a04@mail.gmail.com>
	 <20051107165928.GA15586@kroah.com>
	 <20051107235035.2bdb00e1.akpm@osdl.org>
	 <489ecd0c0511151944r1552bae3oed5ee88a49795482@mail.gmail.com>
	 <20051115221146.4487657f.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/05, Paul Jackson <pj@sgi.com> wrote:
> Luke wrote:
> > > Cow.  You know that volatile in-kernel is basically always wrong?
> > >
> >   I really don't know that...  Could you refer me to any document or
> > posts talking about it? thank you!
>
> Start with:
>
>   http://lkml.org/lkml/2004/1/6/139
>
> > Date  Tue, 6 Jan 2004 10:02:18 -0800 (PST)
> > From  Linus Torvalds <>
> > Subject       Re: [PATCH] fix get_jiffies_64 to work on voyager
> >
> > [ This is a big rant against using "volatile" on data structures. Feel
> >   free to ignore it, but the fact is, I'm right. You should never EVER use
> >   "volatile" on a data structure. ]

   Well, as this post pointed out, some "volatile" are fine.
Especially when you want to visit hardware registers... On the
embedded platforms like Blackfin, ARM, there must be many "volatile"
in the code.

  And we will avoid using "volatile" out of the reasonable range.

>
> --
>                   I won't rest till it's the best ...
>                   Programmer, Linux Scalability
>                   Paul Jackson <pj@sgi.com> 1.925.600.0401
>
