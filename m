Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266124AbUG0P7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266124AbUG0P7n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 11:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266126AbUG0P7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 11:59:43 -0400
Received: from webmail-benelux.tiscali.be ([62.235.14.106]:1618 "EHLO
	mail.tiscali.be") by vger.kernel.org with ESMTP id S266124AbUG0P73 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 11:59:29 -0400
Date: Tue, 27 Jul 2004 17:59:13 +0200
Message-ID: <40FB87C400003E93@ocpmta3.freegates.net>
In-Reply-To: <20040727125432.GA1960@logos.cnet>
From: "Joel Soete" <soete.joel@tiscali.be>
Subject: Re: Some cleanup patches for: '...lvalues is deprecated'
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Cc: "Daniel Jacobowitz" <dan@debian.org>, "Vojtech Pavlik" <vojtech@suse.cz>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

Thanks first for your attention.
Sorry also for delaying this works but I was a bit busy elsewhere.

> -- Original Message --
> Date: Tue, 27 Jul 2004 09:54:32 -0300
> From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
> To: Joel Soete <soete.joel@tiscali.be>
> Cc: Daniel Jacobowitz <dan@debian.org>,
> 	Vojtech Pavlik <vojtech@suse.cz>,
> 	Linux Kernel <linux-kernel@vger.kernel.org>
> Subject: Re: Some cleanup patches for: '...lvalues is deprecated'
> 
> 
> On Mon, Jul 05, 2004 at 01:59:21PM +0200, Joel Soete wrote:
> > Hello Daniel,
> > 
> > > > So just use
> > > >
> > > > 	buffer++;
> > > >
> > > > here, and the intent is then clear.

> > >
> > > Except C does not actually allow incrementing a void pointer, since
> > > void does not have a size.
> > That make better sense to me because aifair a void * was foreseen to
pass
> > any kind of type * as actual parameter?
> > (So as far as I understand, the aritthm pointer sould be dynamic for
the
> > best 'natural' behaviour?)
> > 
> > >   You can't do arithmetic on one either.  GNU
> > > C allows this as an extension.
> > >
> > > It's actually this, IIRC:
> > >   buffer = ((char *) buffer) + 1;
> 
> Joel, 
> 
> It seems the current code is working perfectly, generating correct
> asm code. 
> 
> Could you come up with a good enough reason to do this cleanup (as far
as
> 
> I am concerned) in 2.4.x series?
> 
My first attention was to cleanup some warning of type "use of cast expression
as lvalue is deprecated"
with gcc-3.3.4. But afaik, right now, there are just few warning which didn't
break the asm code.

I will try to come back asap with a better solution (at least I hope ;)
)

Thanks again,
   Joel

---------------------------------------------------------------------------
Tiscali ADSL LIGHT, 19,95 EUR/mois pendant 6 mois, c'est le moment de faire
le pas!
http://reg.tiscali.be/default.asp?lg=fr




