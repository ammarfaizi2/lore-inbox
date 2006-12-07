Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031921AbWLGJsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031921AbWLGJsg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 04:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031919AbWLGJsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 04:48:36 -0500
Received: from cantor.suse.de ([195.135.220.2]:42528 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031917AbWLGJsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 04:48:35 -0500
Date: Thu, 7 Dec 2006 10:48:33 +0100
From: Jan Blunck <jblunck@suse.de>
To: Phil Endecott <phil_arcwk_endecott@chezphil.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Subtleties of __attribute__((packed))
Message-ID: <20061207094833.GD4942@hasse.suse.de>
References: <4de7f8a60612060704k7d7c1ea3o1d43bee6c5e372d4@mail.gmail.com> <1165418558832@dmwebmail.belize.chezphil.org> <20061206155439.GA6727@hasse.suse.de> <20061206175423.GA9959@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061206175423.GA9959@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, Russell King wrote:

> On Wed, Dec 06, 2006 at 04:54:39PM +0100, Jan Blunck wrote:
> > Maybe the arm backend is somehow broken. AFAIK (and I verfied it on S390 and
> > i386) the alignment shouldn't change.
> 

Once again: I refered to "packed attribute on the struct vs. packed attribute
on each member of the struct". The alignment shouldn't be different.

> Please read the info pages:
> 
> `packed'
>      This attribute, attached to an `enum', `struct', or `union' type
>      definition, specifies that the minimum required memory be used to
>      represent the type.
> 
>      Specifying this attribute for `struct' and `union' types is
>      equivalent to specifying the `packed' attribute on each of the
>      structure or union members.  Specifying the `-fshort-enums' flag
>      on the line is equivalent to specifying the `packed' attribute on
>      all `enum' definitions.
> 
> Note that it says *nothing* about alignment.  It says "minimum required
> memory be used to represent the type." which implies that the internals
> of the structure are packed together as tightly as possible.
> 
> It does not say "and as such the struct may be aligned to any alignment".
> 

And this is why it makes sense to think about align attribute when you use
packed.
