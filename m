Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268895AbTGJDTg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 23:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268896AbTGJDTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 23:19:36 -0400
Received: from www.13thfloor.at ([212.16.59.250]:10138 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S268895AbTGJDTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 23:19:24 -0400
Date: Thu, 10 Jul 2003 05:34:09 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: RFC:  what's in a stable series?
Message-ID: <20030710033409.GA1498@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <3F0CBC08.1060201@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3F0CBC08.1060201@pobox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 09:06:16PM -0400, Jeff Garzik wrote:
> So, I was wondering if it is possible to find a consensus 
> on what sorts of changes are ok in a stable series, 
> as it matures.  This mainly applies to 2.4 right now, 
> but I am interested in thoughts on 2.6.x also.
> 
> What do to?

In my opinion (and you requested input *g*), the
kernel userland API can be changed as much as is
required to improve/stabilize/bugfix the kernel,
unless this change breaks something in userland
without an already available update/upgrade/etc ...

To me it makes no sense to keep an API or some
kind of compatibilty thing alive, just because
it was defined somewhere along the way, and some
programmer might have picked it up ...

when (for example) I decide to use devfs at boot
time, completely replacing the traditional /dev
I will certainly break some scripts/applications, 
but it is my decision to do so. The same is true 
for any kernel update, except for security bugfixes, 
which are pretty well handled by the big distros
anyway ...

In general, I would prefer some -preX series, 
introducing a new feature or API, hanging around
some time (two to three weeks) with occasional
code cleanups, waiting for somebody shouting 
"hey guys, this stuff breaks my famous wossname".

In the end either the new feature is silently
accepted, or backed out, starting a new cycle of 
feature add/feature settle ...

> Does it mean, no API changes except for security 
> (or similarly severe) bugs?

security issues should be addressed in any case.

> Does it mean, no userland ABI changes, but API changes 
> affecting only the kernel are ok?

if some change affects one or two driver 
developer (read only a few people), then they
should agree on a change and let the people
test whatever they've agreed on ...

> Does it mean, "just don't break things such that people are pissed off"?

I guess this will be the most favored answer 
from any user ... and at least some developers ...

> I request the community's input, particularly those 
> CC'd, for some sort of direction or consensus on this.
> 
> In any case, I personally feel that increased stability of the API, 
> coupled with the increased frequency of releases, will make the most 
> people happy.  I would prefer some sort of 2.4.x API freeze, say 
> post-2.4.22, but maybe that's too radical?

I guess this depends on the actual 2.6 time frame ...

best,
Herbert

