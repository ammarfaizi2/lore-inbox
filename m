Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264667AbTGBHOo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 03:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264786AbTGBHOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 03:14:44 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:31980 "HELO
	develer.com") by vger.kernel.org with SMTP id S264667AbTGBHOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 03:14:43 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] Kill div64.h dupes, parenthesize do_div() macro params
Date: Wed, 2 Jul 2003 09:28:38 +0200
User-Agent: KMail/1.5.9
References: <200307020232.20726.bernie@develer.com> <200307020852.17782.bernie@develer.com> <20030702071919.GP3040@dualathlon.random>
In-Reply-To: <20030702071919.GP3040@dualathlon.random>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307020928.38830.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 July 2003 09:19, you wrote:
 > On Wed, Jul 02, 2003 at 08:52:17AM +0200, Bernardo Innocenti wrote:
 > > + *	static inline uint32_t do_div(uint64_t &n, uint32_t base)
 >
 > c++ ;)

 Oops! Shall I send a new patch? ;-)

 > > +# error do_div() does not yet support the C64
 >
 > ;)
 >
 > this new version looks good to me since it will fix bugs and it's not
 > only a cleanup avoiding code duplication. thanks.

 The previous patch was not just a cleanup: it actually added parenthes
that were missing around parameters in many do_div() variants. Guess
what happened when shrink_slab() did this (pages = 0):

   do_div(delta, pages + 1); /* Ouch! */

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


