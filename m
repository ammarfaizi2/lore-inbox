Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbTGFRW5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 13:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263025AbTGFRW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 13:22:56 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:41621 "HELO
	develer.com") by vger.kernel.org with SMTP id S262874AbTGFRWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 13:22:55 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer
To: Philippe Elie <phil.el@wanadoo.fr>
Subject: Re: SPAM[RBL] Re: C99 types VS Linus types
Date: Sun, 6 Jul 2003 19:37:26 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>
References: <200307060703.58533.bernie@develer.com> <3F0814B1.1000401@wanadoo.fr>
In-Reply-To: <3F0814B1.1000401@wanadoo.fr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307061937.26519.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 July 2003 14:23, Philippe Elie wrote:

 > alpha user space .h define uint64_t as unsigned long,
 > include/asm-alpha/types.h defines it as unsigned long long.

 Why is that? Isn't uint64_t supposed to be _always_ a 64bit
unsigned integer? Either the kernel or the user space might
be doing the wrong thing...

 I've Cc'd the Alpha mantainer to make him aware of this
problem.

 > Using a different definition (if it's possible) will be
 > confusing. Using the same definition as user space means
 > than code like:
 >
 > uint64 t u;
 > printk("%lu", u);
 >
 > will not compile on alpha. This problem is solved in C99
 > by using PRI_xxx format specifier macro, I'm not a great
 > fan of this idea.

 This is ugly, but there is no way around it. No matter what
typedefs you're using, C99 or not, printf size specifiers are
always bound to plain C types, whose size varies from
platform to platform.

 > surely vim allow to define your own set of type ?

 Yeah, but not if you're lazy ;-)

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


