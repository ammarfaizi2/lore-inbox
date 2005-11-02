Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965140AbVKBR0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbVKBR0p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 12:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbVKBR0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 12:26:45 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:64262 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S965140AbVKBR0o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 12:26:44 -0500
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "Alex Lyashkov" <umka@sevcity.net>, "Giuliano Pochini" <pochini@shiny.it>,
       <alex@alexfisher.me.uk>, <linux-kernel@vger.kernel.org>,
       "Jeff V. Merkey" <jmerkey@utah-nac.org>,
       "Michael Buesch" <mbuesch@freenet.de>
Subject: Re: Would I be violating the GPL?
References: <XFMail.20051102104916.pochini@shiny.it>
	<1130943242.3367.39.camel@berloga.shadowland>
	<87fyqfm5jx.fsf@amaterasu.srvr.nix>
	<Pine.LNX.4.61.0511021108410.15964@chaos.analogic.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: Lovecraft was an optimist.
Date: Wed, 02 Nov 2005 17:26:17 +0000
In-Reply-To: <Pine.LNX.4.61.0511021108410.15964@chaos.analogic.com> (linux-os@analogic.com's
 message of "Wed, 2 Nov 2005 11:16:03 -0500")
Message-ID: <87br13m05i.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, linux-os@analogic.com announced authoritatively:
> 2. New and delete are a bitch.

s/a bitch/trivial/

they're wrappers around the appropriate kernel memory allocators.

> 3. Link will fail because of the hidden stuff C++ needs that it
>     can't find. Okay, just generate some dummy symbols in asm,
>     all pointing to the same junk.

Obviously if you try using EH it will always crash hard. That
would be really stupid.

> 4. Once you got it to load, gigantic stack usage will crash.

Er, C++ does not imply `gigantic stack usage'.

However, C++ *will* be discomfited by `struct class', and unless you
want to rule out use of sysfs you're going to have to use it at some
point. And *that* is a bit of a killer unless you want to write half
your app in C and half in C++, which is getting a bit silly.

> So much for C++. Just use C. He probably didn't remember that
> it's a simpler variant.

It's a quite different language which happens to share a lot of ancestry
with C, and which happens to make link-time compatibility with C fairly
easy. Therefore it looks fairly similar; but it is *not* that similar,
not any more. Good C code and good C++ code look utterly different,
and good C++ code probably has no place in the kernel (making, as it
does, heavy use of the templated standard C++ library).

But, no, it doesn't belong in the kernel. (If you're writing a
filesystem, though, filesystem drivers in C++ --- or, for that matter,
Perl, Java or Haskell --- are quite practicable, thanks to the merging
of FUSE.)

-- 
`"Gun-wielding recluse gunned down by local police" isn't the epitaph
 I want. I am hoping for "Witnesses reported the sound up to two hundred
 kilometers away" or "Last body part finally located".' --- James Nicoll
