Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264447AbTDXEok (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 00:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbTDXEok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 00:44:40 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34822 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264447AbTDXEo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 00:44:27 -0400
Date: Wed, 23 Apr 2003 21:57:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Greg KH <greg@kroah.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp!
In-Reply-To: <20030424044328.GA15360@kroah.com>
Message-ID: <Pine.LNX.4.44.0304232146020.19326-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Apr 2003, Greg KH wrote:
> On Wed, Apr 23, 2003 at 08:59:45PM -0700, Linus Torvalds wrote:
> > 
> > Btw, one thing that is clearly _not_ allowed by the GPL is hiding private
> > keys in the binary. You can sign the binary that is a result of the build
> > process, but you can _not_ make a binary that is aware of certain keys
> > without making those keys public - because those keys will obviously have
> > been part of the kernel build itself.
> 
> The GPL does allow you to embed a public key in the kernel

Absolutely. That's why I said "private key".

It's clearly ok to embed any number of keys you damn well want inside the
kernel itself - it's just that the GPL requires that they be made
available as source, so by implication they had damn well better be
public.

So yes, it's perfectly fine to embed a public key inside the kernel, and 
use that public key to verify some external private key. 

> I know a lot of people can (and do) object to such a potential use of
> Linux, and I'm glad to see you explicitly state that this is an
> acceptable use, it helps to clear up the issue.

The reason I want to make it very explicit is that I know (judging from
the private discussions I've had over the last few weeks) that a lot of
people think that the GPL can be interpreted in such a way that even just
the act of signing a binary would make the key used for the signing be
covered by the GPL. Which obviously would make the act of signing
something totally pointless.

And even if some lawyer could interpret it that way (and hey, they take
limbo classes in law school explicitly to make sure that the lawyers _are_
flexible enough.  Really! Look it up in the dictionary - right next to
"gullible"), I wanted to make sure that we very explicitly do NOT
interpret it that way.

Because signing is (at least right now) the only way to show that you 
trust something. And if you can't show that you trust something, you can't 
have any real security.

The problem with security, of course, is exactly _whom_ the security is
put in place to protect. But that's not a question that we can (or should)
try to answer in a license. That's a question that you have to ask 
yourself when (and if) you're presented with such a device.

			Linus

