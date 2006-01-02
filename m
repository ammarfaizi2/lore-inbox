Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWABSoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWABSoI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 13:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWABSoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 13:44:08 -0500
Received: from khc.piap.pl ([195.187.100.11]:11268 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1750933AbWABSoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 13:44:07 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Adrian Bunk <bunk@stusta.de>, Arjan van de Ven <arjan@infradead.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
References: <20051229224839.GA12247@elte.hu>
	<1135897092.2935.81.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de>
	<20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de>
	<20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de>
	<20060102103721.GA8701@elte.hu>
	<1136198902.2936.20.camel@laptopd505.fenrus.org>
	<20060102134345.GD17398@stusta.de> <20060102140511.GA2968@elte.hu>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 02 Jan 2006 19:44:02 +0100
In-Reply-To: <20060102140511.GA2968@elte.hu> (Ingo Molnar's message of "Mon, 2 Jan 2006 15:05:11 +0100")
Message-ID: <m3ek3qcvwt.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> what is the 'deeper problem'? I believe it is a combination of two 
> (well-known) things:
>
>   1) people add 'inline' too easily
>   2) we default to 'always inline'

For example, I add "inline" for static functions which are only called
from one place.

If I'm able to say "this is static function which is called from one
place" I'd do so instead of saying "inline". But omitting the "inline"
with hope that some new gcc probably will inline it anyway (on some
platform?) doesn't seem like a best idea.

But what _is_ the best idea?
-- 
Krzysztof Halasa
