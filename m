Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312938AbSFXMNL>; Mon, 24 Jun 2002 08:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313060AbSFXMNL>; Mon, 24 Jun 2002 08:13:11 -0400
Received: from hugin.diku.dk ([130.225.96.144]:41220 "HELO hugin.diku.dk")
	by vger.kernel.org with SMTP id <S312938AbSFXMNJ>;
	Mon, 24 Jun 2002 08:13:09 -0400
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: henning@makholm.net, bug-make@gnu.org, linux-hams@vger.kernel.org,
       linux-kernel@vger.kernel.org, sailer@ife.ee.ethz.ch
Subject: Re: make-3.79.1 bug breaks linux-2.5.24/drivers/net/hamradio/soundmodem
References: <200206222156.OAA00651@baldur.yggdrasil.com>
X-My-Web-page: http://www.diku.dk/~makholm/
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
From: Henning Makholm <henning@makholm.net>
Date: 24 Jun 2002 14:13:10 +0200
In-Reply-To: "Adam J. Richter"'s message of "Sat, 22 Jun 2002 14:56:23 -0700"
Message-ID: <yahn0tklvs9.fsf@pc-043.diku.dk>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scripsit "Adam J. Richter" <adam@yggdrasil.com>

> >I'm not sure this is really a bug either. It is a Good Thing that make
> >tries to normalize the names of targets and dependencies internally,
> >lest the build may be incomplete or redundant if make does not realize
> >that foo.bar and ./foo.bar is the same file. It is quite reasonable
> >for $< to unfold to the *canonical* name of the file in question, I
> >think.

> 	That just makes the behavior of make less predictable.
> Whatever make does with the file names internally is its own business.
> Rewriting the file names passed to commands unnecessarily is
> potentially a big problem.

It is not rewriting file names. It is just substituting the name of
the dependency for the $< variable, just as documented.

> >If one absolutely wants the command to use the exact form of the
> >dependency that's used in the dependency list, it's easy to simply
> >reproduce that form, replacing the % by $*

> 	Sorry, I do not understand what you mean.

It wasn't right anyway. I remembered the semantics of $* when the file
name contains slashes wrong.

-- 
Henning Makholm                      "They are trying to prove a hypothesis,
                             they are down here gathering data every season,
                       they're publishing results in peer-reviewed journals.
                     They're wrong, I think, but they are still scientists."
