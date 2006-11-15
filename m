Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966004AbWKOJFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966004AbWKOJFi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 04:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966707AbWKOJFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 04:05:38 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:19419 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S966004AbWKOJFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 04:05:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WoWwT1OgDai0C9YVxlB9evOEH/S6BbZXLhjmO/j5ghncCtk9VEASOFinwF6No+g7/t8R4XYanNHPa9wTcKFqnQ+DaUdrmcAt04n6oPDu1FHCEPWVzIRBHuSMPZvtWg28Za8nCmcacgAFustICnfnQ7lNui5Pej7FrZp6xIAgAWo=
Message-ID: <9a8748490611150105u2c3c1a4fucc3e7ad5f1fd1d77@mail.gmail.com>
Date: Wed, 15 Nov 2006 10:05:35 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Randy Dunlap" <randy.dunlap@oracle.com>
Subject: Re: [KJ][PATCH] Correct misc_register return code handling in several drivers
Cc: "Andrew Morton" <akpm@osdl.org>, "Neil Horman" <nhorman@tuxdriver.com>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       kernel-janitors@lists.osdl.org, kjhall@us.ibm.com, maxk@qualcomm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061114160431.068046ca.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061023171910.GA23714@hmsreliant.homelinux.net>
	 <200611020144.51196.jesper.juhl@gmail.com>
	 <454945FA.8030901@oracle.com>
	 <200611020223.43011.jesper.juhl@gmail.com>
	 <20061101172241.84439229.randy.dunlap@oracle.com>
	 <20061114160431.068046ca.randy.dunlap@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/06, Randy Dunlap <randy.dunlap@oracle.com> wrote:
> On Wed, 1 Nov 2006 17:22:41 -0800 Randy Dunlap wrote:
>
> > On Thu, 2 Nov 2006 02:23:42 +0100 Jesper Juhl wrote:
> >
...
> > >
> > > Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> > > ---
> > >
> > > diff --git a/Documentation/CodingStyle b/Documentation/CodingStyle
> > > index 29c1896..4f6b2d5 100644
> > > --- a/Documentation/CodingStyle
> > > +++ b/Documentation/CodingStyle
> > > @@ -566,6 +566,21 @@ result.  Typical examples would be funct
> > >  NULL or the ERR_PTR mechanism to report failure.
> > >
> > >
> > > +           Chapter 17: Labels
> > > +
> > > +Label names should be lowercase.
> > > +
> > > +Label names should start with a letter [a-z].
> > > +
> > > +Labels should not be placed at column 0. Doing so confuses some tools, most
> > > +notably 'diff' and 'patch'. Instead place labels at column 1 (indented 1
> > > +space). In some cases it's OK to indent labels one or more tabs, but
> > > +generally it is preferred that labels be placed at column 1.
> > > +
> > > +Labels should stand out - be easily visible. They should not be indented so
> > > +much that they are hidden or obscured by the surrounding source code.
> > > +
> > > +
> > >
> > >             Appendix I: References
> >
> > Yep, OK with me.  (Ack)
> > ---
>
> Did Andrew ever pick up this doc. patch?
>
Not as far as I know.


> Anyway, I wanted to see the problem with 'diff' and labels in column 0
> causing 'diff -p' @@ tags to be confused, but when I tested it,
> it Works For Me.  No difference in diff @@ tags if I indent the
> labels or not.  or is this too simple?

I must admit that I've not been able to cause a failure either, an
example would be nice.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
