Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267894AbUGWS5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267894AbUGWS5r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 14:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267921AbUGWS5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 14:57:47 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:30368 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S267894AbUGWS5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 14:57:06 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: linux-kernel@vger.kernel.org
Subject: [RFC]: CONFIG_UNSUPPORTED (was: Re: [PATCH] delete devfs)
Date: Fri, 23 Jul 2004 21:06:40 +0200
User-Agent: KMail/1.5
References: <20040721141524.GA12564@kroah.com> <20040722064952.GC20561@kroah.com> <20040722091335.A17187@home.com>
In-Reply-To: <20040722091335.A17187@home.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407232106.41065.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi listmembers,

I'm not a kernel developer, but recently I've been testing many development 
(ie. -mm and -rc) kernels and I run a network containing quite a lot of Linux 
boxes, so I'm involved (a little) in the kernel development or at least I'm 
affected by it to some extent.  Anyway, I have an idea that I think you may 
find interesting.

1. Background

There apparently is some code in the kernel tree that is buggy and not 
maintained by anyone.  The recent attempts to remove some parts of it (devfs, 
cryptoloop) have been opposed, as it turns out that they are still in use.

OTOH, because this code is present in the mainline kernel, the users of the 
kernel can expect that the code will be supported by kernel developers, which 
is not correct.  Therefore the code should be removed from the kernel, so 
that it's not used by any new users who may expect it to be supported (there 
are many other reasons for removing it, but this one alone is sufficient, 
IMHO).

Having said that, it is not very nice to pull rugs from under people in 
general, so before the unmaintained code is removed from the kernel, its 
current users should be given some time to accommodate to the upcoming 
changes.  Therefore the unsupported code should be made clearly 
distinguishable from the rest of the kernel code and documented as such, in 
order to indicate to the users that it may be removed at any time.

2. Proposal

I propose to introduce a new configuration option CONFIG_UNSUPPORTED, such 
that if it is not set, the unmaintained/unsupported code will not be compiled 
into the kernel.  Moreover,
* IMO the option should not be set by default, which would require a user 
action to include the unsupported code into the kernel,
* IMO the option should be documented as to indicate that the code marked with 
the help of it is not supported by kernel developers and may be removed from 
the kernel at any time without notification.

I think that this would be fair enough wrt. users, who would be able to learn 
that the code is not maintained and may be removed at any time without 
notification, and they should not expect to get any support ftom the kernel 
developers wrt. this code, and it's generally not a good idea to file any bug 
reports regarding this code, because the bugs in it will not be fixed anyway.

OTOH, it would give the kernel developers a means to mark 
unsupported/unmaintained code as such in advance, without harming any users 
in the short run.

Yours,
rjw

-- 
Rafael J. Wysocki
[tel. (+48) 605 053 693]
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
