Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbTLHS1V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 13:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTLHS1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 13:27:21 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:55784 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261606AbTLHS1P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 13:27:15 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16340.49791.585097.389128@laputa.namesys.com>
Date: Mon, 8 Dec 2003 21:27:11 +0300
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: const versus __attribute__((const))
In-Reply-To: <3FD4B9E6.9090902@zytor.com>
References: <200312081646.42191.arnd@arndb.de>
	<3FD4B9E6.9090902@zytor.com>
X-Mailer: VM 7.17 under 21.5 (patch 16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
 > Arnd Bergmann wrote:
 > > H. Peter Anvin writes:
 > > 
 > >>I have made a patch against the current tree defining
 > >>__attribute_const__ in <linux/compiler.h> and using it in the above
 > >>cases; does anyone know any reason why I should *NOT* submit this to
 > >>Linus?
 > > 
 > > 
 > > I noticed before that gcc appearantly ignores __attribute__((const))
 > > for inline functions, so both the original and your proposed code
 > > is rather pointless as an optimization, except for extern declarations.
 > > 
 > > I'd rather remove the 'const' completely where it causes warnings for
 > > inline functions.
 > > 
 > 
 > These functions are available to userspace, though, and can be compiled 
 > with -O0; thus not inlined.

And future versions of gcc can be smarter.

 > 
 > 	-hpa

Nikita.

