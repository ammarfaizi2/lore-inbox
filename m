Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265973AbUG0N5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUG0N5T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 09:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266018AbUG0N5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 09:57:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42208 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265973AbUG0N5R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 09:57:17 -0400
Date: Tue, 27 Jul 2004 09:54:32 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Joel Soete <soete.joel@tiscali.be>
Cc: Daniel Jacobowitz <dan@debian.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Some cleanup patches for: '...lvalues is deprecated'
Message-ID: <20040727125432.GA1960@logos.cnet>
References: <20040705051010.GA24583@nevyn.them.org> <40BD9F8700015B8E@ocpmta2.freegates.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BD9F8700015B8E@ocpmta2.freegates.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2004 at 01:59:21PM +0200, Joel Soete wrote:
> Hello Daniel,
> 
> > > So just use
> > >
> > > 	buffer++;
> > >
> > > here, and the intent is then clear.
> >
> > Except C does not actually allow incrementing a void pointer, since
> > void does not have a size.
> That make better sense to me because aifair a void * was foreseen to pass
> any kind of type * as actual parameter?
> (So as far as I understand, the aritthm pointer sould be dynamic for the
> best 'natural' behaviour?)
> 
> >   You can't do arithmetic on one either.  GNU
> > C allows this as an extension.
> >
> > It's actually this, IIRC:
> >   buffer = ((char *) buffer) + 1;

Joel, 

It seems the current code is working perfectly, generating correct
asm code. 

Could you come up with a good enough reason to do this cleanup (as far as 
I am concerned) in 2.4.x series?

Thanks
