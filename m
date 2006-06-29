Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932690AbWF2Kze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbWF2Kze (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 06:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbWF2Kzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 06:55:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39595 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932556AbWF2Kzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 06:55:32 -0400
Subject: Re: [PATCH] ia64: change usermode HZ to 250
From: Arjan van de Ven <arjan@infradead.org>
To: Jes Sorensen <jes@sgi.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Luck, Tony" <tony.luck@intel.com>,
       John Daiker <jdaiker@osdl.org>, John Hawkes <hawkes@sgi.com>,
       Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jack Steiner <steiner@sgi.com>, Dan Higgins <djh@sgi.com>,
       Jeremy Higdon <jeremy@sgi.com>
In-Reply-To: <44A3AFFB.2000203@sgi.com>
References: <617E1C2C70743745A92448908E030B2A27FC5F@scsmsx411.amr.corp.intel.com>
	 <yq04py4i9p7.fsf@jaguar.mkp.net>
	 <1151578928.23785.0.camel@localhost.localdomain> <44A3AFFB.2000203@sgi.com>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 12:55:13 +0200
Message-Id: <1151578513.3122.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-29 at 12:48 +0200, Jes Sorensen wrote:
> Alan Cox wrote:
> > Ar Iau, 2006-06-29 am 05:37 -0400, ysgrifennodd Jes Sorensen:
> >> You have my vote for that one. Anything else is just going to cause
> >> those broken userapps to continue doing the wrong thing. We should
> >> really do this on all archs though.
> > 
> > No need, all current mainstream architectures expose a constant user HZ.
> 
Hi,

> But you are still going to have the issue where someone installs their
> own kernel and apps will break because of this?

to answer that question with one word: no.

read what Alan said: the HZ exposed to userspace is *constant*. For
example, the i386 user visible HZ is 100, even if the kernel runs at a
HZ of 250 or 1000.... Just when a HZ value gets exposed to userspace,
it's transformed into a HZ=100 based value.

And that's not a distribution thing, that's the kernel.org kernel
honoring the stable-userspace-interface contract, and common sense..

Greetings,
   Arjan van de Ven

