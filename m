Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWABUTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWABUTJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 15:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbWABUTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 15:19:09 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:11394 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751019AbWABUTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 15:19:08 -0500
Date: Mon, 2 Jan 2006 21:18:47 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Adrian Bunk <bunk@stusta.de>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20060102201847.GB9935@wohnheim.fh-wedel.de>
References: <20051231150831.GL3811@stusta.de> <20060102103721.GA8701@elte.hu> <1136198902.2936.20.camel@laptopd505.fenrus.org> <20060102134345.GD17398@stusta.de> <20060102140511.GA2968@elte.hu> <m3ek3qcvwt.fsf@defiant.localdomain> <1136227893.2936.51.camel@laptopd505.fenrus.org> <m34q4mpfz9.fsf@defiant.localdomain> <1136231656.2936.57.camel@laptopd505.fenrus.org> <m3sls6o0ok.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m3sls6o0ok.fsf@defiant.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 January 2006 21:05:31 +0100, Krzysztof Halasa wrote:
> Arjan van de Ven <arjan@infradead.org> writes:
> 
> > it's by far not only gains. And maintenance costs too.
> 
> Anyway, distinctive "inlines" could help here, right?

Not really.  Your example, as Linus already explained, is a great
example of how _not_ to inline stuff.  If in doubt, don't inline.  If
a function is called just once, don't inline unless there are other
good reasons for it.  If you get a minimal gain (10 bytes) in text
size, don't inline.  The maintenance issue is more important.

Jörn

-- 
A defeated army first battles and then seeks victory.
-- Sun Tzu
