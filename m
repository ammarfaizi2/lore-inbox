Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161003AbWGINvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161003AbWGINvD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 09:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161004AbWGINvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 09:51:03 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:64195 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161003AbWGINvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 09:51:00 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Bojan Smojver <bojan@rexursive.com>
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Date: Sun, 9 Jul 2006 15:51:18 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@ucw.cz>, Arjan van de Ven <arjan@infradead.org>,
       Sunil Kumar <devsku@gmail.com>, Avuton Olrich <avuton@gmail.com>,
       Olivier Galibert <galibert@pobox.com>, Jan Rychter <jan@rychter.com>,
       linux-kernel@vger.kernel.org, suspend2-devel@lists.suspend2.net,
       grundig <grundig@teleline.es>,
       Nigel Cunningham <ncunningham@linuxmail.org>
References: <20060627133321.GB3019@elf.ucw.cz> <20060709003230.GA1753@elf.ucw.cz> <1152407148.2598.10.camel@coyote.rexursive.com>
In-Reply-To: <1152407148.2598.10.camel@coyote.rexursive.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607091551.18456.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 July 2006 03:05, Bojan Smojver wrote:
> On Sun, 2006-07-09 at 02:32 +0200, Pavel Machek wrote:
> 
> > I wanted to point out that delay between "okay, I want this gone" and
> > the code disappearing from kernel tarball is about a year.
> 
> OK, so the period for this kind of solution(s) to completely go away is
> even longer.
> 
> Which brings me to my point. Given that with my proposal you would have
> zero involvement with Suspend2 code (i.e. you would not be obligated to
> fix/touch/do anything in *any way*), why not give Nigel a go? The man is
> obviously willing to do stuff on his own and it won't cost you anything.

The problem is he _can't_ do it on his own if he wants the code merged,
because for this purpose some people have to review it, and that's not
only me or Pavel, but also architecture maintainers, memory management
maintainers, and probably some other people too.  Moreover, Nigel needs
to address the issues raised by the reviewers.

> And if it doesn't work out - well, though luck for Nigel.

Some people have reviewed some parts of suspend2 recently and there
were some comments to address.  Now it's up to Nigel to address them or not,
and that's only the tip of the iceberg.  It'll take quite some time to review
the entire suspend2 and address all of the issues that people may have with
it.  This is a long way to go, but I personally am not against doing it.

Now there's the separate problem that we have to share _some_ code.
To an absolute minimum, we have to share the freezer code and the
code that handles devices, because it's also shared by suspend-to-RAM.
The code that handles devices is already shared, but we also _have_ _to_
share the freezer code.  Therefore, as long as suspend2 adds some code
to the freezer, it's not even close to be considerable for merging.

The additional freezer code from suspend2 needs to be either merged or
dropped _first_, before we can even think of including the rest of suspend2
in -mm.

Greetings
Rafael
