Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWGKDCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWGKDCF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 23:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWGKDCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 23:02:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:1991 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932374AbWGKDCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 23:02:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=akphvvyWIWJkGO23zGIdvAEBf+qo6boyf0qklea4fx2KWgzAZmgH0aHk7KnKZtIlL1P2/muzwM1oTprfI9nedLnkHV3LL7LHfqRlLzjLkQ7qCsbaJMfqBvG3x08NjzPqN9EEU4GxGN8Or+hfkgMdXhJg2bVtP1o2JqXHYUT87VQ=
Message-ID: <ed5aea430607102001g514bfa97jf82c25a038e9c436@mail.gmail.com>
Date: Mon, 10 Jul 2006 21:01:53 -0600
From: "David Mosberger-Tang" <David.Mosberger@acm.org>
To: "Jeremy Higdon" <jeremy@sgi.com>
Subject: Re: [PATCH] ia64: change usermode HZ to 250
Cc: "Arjan van de Ven" <arjan@infradead.org>, "Jes Sorensen" <jes@sgi.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Luck, Tony" <tony.luck@intel.com>, "John Daiker" <jdaiker@osdl.org>,
       "John Hawkes" <hawkes@sgi.com>, "Tony Luck" <tony.luck@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, "Jack Steiner" <steiner@sgi.com>,
       "Dan Higgins" <djh@sgi.com>
In-Reply-To: <20060710202228.GA732959@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <617E1C2C70743745A92448908E030B2A27FC5F@scsmsx411.amr.corp.intel.com>
	 <yq04py4i9p7.fsf@jaguar.mkp.net>
	 <1151578928.23785.0.camel@localhost.localdomain>
	 <44A3AFFB.2000203@sgi.com>
	 <1151578513.3122.22.camel@laptopd505.fenrus.org>
	 <20060708001427.GA723842@sgi.com>
	 <1152340963.3120.0.camel@laptopd505.fenrus.org>
	 <ed5aea430607080607u67aeb05di963243c0e653e4f0@mail.gmail.com>
	 <20060710202228.GA732959@sgi.com>
X-Google-Sender-Auth: 3db5ec7f3fd8c4f1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/06, Jeremy Higdon <jeremy@sgi.com> wrote:
> On Sat, Jul 08, 2006 at 07:07:14AM -0600, David Mosberger-Tang wrote:
> > Nothing is broken.  Read Alan's statement carefully...
> >
> >  --david
>
> His statement can be read a couple of ways.

Alan said:

--------------------------------------------------------------
From: Alan Cox <alan_at_lxorguk.ukuu.org.uk>
Date: 2006-06-29 21:02:08

Ar Iau, 2006-06-29 am 05:37 -0400, ysgrifennodd Jes Sorensen:
> You have my vote for that one. Anything else is just going to cause
> those broken userapps to continue doing the wrong thing. We should
> really do this on all archs though.

No need, all current mainstream architectures expose a constant user HZ.

Alan
--------------------------------------------------------------

Note that Alan didn't claim that *all* (Linux-supported) architectures
expose a constant user HZ, only the "mainstream" ones.  I won't get
into the debate as to what qualifies as "mainstream", but clearly IA64
does not (and should not) expose a constant value, since there were no
legacy-binary-issue and we chose to insist that apps should uses
sysconf() or equivalent if they need to know the clocktick.

  --david
-- 
Mosberger Consulting LLC, http://www.mosberger-consulting.com/
