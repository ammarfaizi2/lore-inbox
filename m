Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318572AbSIBX2D>; Mon, 2 Sep 2002 19:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318591AbSIBX2C>; Mon, 2 Sep 2002 19:28:02 -0400
Received: from mail.zmailer.org ([62.240.94.4]:39328 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S318572AbSIBX2B>;
	Mon, 2 Sep 2002 19:28:01 -0400
Date: Tue, 3 Sep 2002 02:32:30 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Stupid anti-spam testings...
Message-ID: <20020902233230.GC5834@mea-ext.zmailer.org>
References: <20020902215019.GB5834@mea-ext.zmailer.org> <20020902222837.GM32468@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020902222837.GM32468@clusterfs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2002 at 04:28:37PM -0600, Andreas Dilger wrote:
...
> > Folks,  when you deploy that kind of testers, DO VERIFY THAT THEY
> > HAVE SANE CACHES!  A positive result shall be cached for at least
> > two hours, a negative result shall be cached for at least 30 minutes.
> 
> Do you know if this is one of the default checks from spamassassin?

  No idea.  I have seen these coming from Exim 4.10, Exim-something,
  some sendmail milter (whatever that is), etc..

  Apparently the idea (which I have thought of long ago, and rejected
  as incomplete) has caught, and has multiple implementations...

> I would imagine that a lot of people (including myself) have it
> installed, so it is possible that it (or some other widely-used tool)
> now does this sort of check out-of-the-box, and the people who are
> installing them have no idea about the kind of load it generates on vger.
> I doubt that there are a large number of people who are independently
> misconfiguring their mail setup this way

  I can easily reduce the load impact it causes to vger by
  running the smtp server in "accept everything" mode without
  analyzing local addresses for existence.  With a bit more
  work I can throw in local cache..  (which I probably have to do..)

> If it is possible to track what tool is causing the problem and fixing
> the default setup of that tool at the source, it will probably solve
> 99% of the problems in one go (after the list knows to which version
> they should upgrade).

  Raise some noise all around, there are multiple implementations
  of the idea.  Some even with syntactically invalid tester codes
  (spaces put in place where they don't belong in RFC 821/2821);
  "works with sendmail" is NOT synonymous to "is syntactically 
  correct."

  - a mister at blue-labs.org  runs some sendmail-milter which
    does testing with invalid protocol syntax
  - usw-sf-list1.sourceforge.net  use probably their own code
    usw-sf-fw2.sourceforge.net too...  possibly more systems there..
  - quetz.demon.co.uk tests from  Exim 4.10
  - somebody.symons.net tests from Exim 3.35

  Right now something like 5-7 different systems are doing it.
  Try to imagine when all 3500 targets do it...  BRRRRR...
  (Sure, VGER can handle it, no problem, but it is that much
   wasted cycles, and network traffic...)

> Cheers, Andreas
> Andreas Dilger

/Matti Aarnio
