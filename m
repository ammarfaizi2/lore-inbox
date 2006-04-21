Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWDUPYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWDUPYE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 11:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWDUPYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 11:24:03 -0400
Received: from uproxy.gmail.com ([66.249.92.168]:894 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932356AbWDUPYB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 11:24:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VAk+ebC4dFIckktKnhZGSDohwlV1Yg8ZiLPXIBsBW6coktzHu7Rls+q0Q0gbMPLMM6ZHMnvPVtJs5ZXkl9zq33X+Mo/j6AmwBvokEzdWXls/6aHMm5rKOSvTwMqfQCrxydtA9Oj/GILIYogygvT7TjCHshg6nwFM/YMOiXX2ghw=
Message-ID: <ef88c0e00604210823j3098b991re152997ef1b92d19@mail.gmail.com>
Date: Fri, 21 Apr 2006 08:23:51 -0700
From: "Ken Brush" <kbrush@gmail.com>
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Cc: "Crispin Cowan" <crispin@novell.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Greg KH" <greg@kroah.com>,
       "James Morris" <jmorris@namei.org>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Andrew Morton" <akpm@osdl.org>, "Stephen Smalley" <sds@tycho.nsa.gov>,
       "T?r?k Edwin" <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, "Chris Wright" <chrisw@sous-sol.org>,
       "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <200604201527.k3KFRNUC009815@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200604021240.21290.edwin@gurde.com>
	 <20060417173319.GA11506@infradead.org>
	 <Pine.LNX.4.64.0604171454070.17563@d.namei>
	 <20060417195146.GA8875@kroah.com>
	 <1145309184.14497.1.camel@localhost.localdomain>
	 <200604180229.k3I2TXXA017777@turing-police.cc.vt.edu>
	 <4445484F.1050006@novell.com>
	 <200604182301.k3IN1qh6015356@turing-police.cc.vt.edu>
	 <4446D378.8050406@novell.com>
	 <200604201527.k3KFRNUC009815@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> On Wed, 19 Apr 2006 17:19:04 PDT, Crispin Cowan said:
> > Valdis.Kletnieks@vt.edu wrote:
> > > In other words, it's quite possible to accidentally introduce a vulnerability
> > > that wasn't exploitable before, by artificially restricting the privs in a way
> > > the designer didn't expect.  So this is really just handing the sysadmin
> > > a loaded gun and waiting.
> > >
> > While that is true of the voluntary model of acquiring and dropping
> > privs, it is not true of AppArmor containment, which will just not give
> > you the priv if it is not in your policy.
>
> The threat model is that you can take a buggy application, and constrain its
> access to priv A in a way that causes a code failure that allows you to abuse
> an unconstrained priv B.

So you are talking about a 2 prong attack. One in where you somehow
trick program A to do something that it's allowed to. That then would
cause an error in program B ? Or cause program B to do something
wonky.

I guess a good example of this would be if you sent an email to
sendmail (which is constrained) to write the message to my mailbox
(which is allowed, obviously).

Then I use an imap daemon (which would not be constrained, in the
hypothetical, personally I constrain everything I can). To retrieve
that message but the payload of the message causes the imap daemon to
delete /lib ?

Is that a proper example? or do you mean something else?

-Ken
