Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272566AbTHNRxs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 13:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272574AbTHNRxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 13:53:47 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:56448 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S272566AbTHNRx3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 13:53:29 -0400
Date: Thu, 14 Aug 2003 18:53:09 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Matt Wilson <msw@redhat.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@redhat.com>, Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] revert zap_other_threads breakage, disallow CLONE_THREAD without CLONE_DETACHED
Message-ID: <20030814175309.GC10889@mail.jlokier.co.uk>
References: <200308120752.h7C7qQT20085@magilla.sf.frob.com> <Pine.LNX.4.44.0308141023480.8148-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308141023480.8148-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> I'd really prefer not to keep a bit around that has to mean the same thing 
> as another bit - that way just lies madness. So I'll document 
> CLONE_DETACHED as being a no-op, and change the _one_ place that used it 
> to just use CLONE_THREAD instead.

Don't forget to mention that software that may be run on 2.5 kernels
needs to set both bits, else won't work as expected.

-- Jamie
