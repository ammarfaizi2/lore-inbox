Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264947AbTLHPtL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 10:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265436AbTLHPtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 10:49:11 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:38831 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S264947AbTLHPtI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 10:49:08 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: const versus __attribute__((const))
Date: Mon, 8 Dec 2003 16:46:42 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312081646.42191.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
> I have made a patch against the current tree defining
> __attribute_const__ in <linux/compiler.h> and using it in the above
> cases; does anyone know any reason why I should *NOT* submit this to
> Linus?

I noticed before that gcc appearantly ignores __attribute__((const))
for inline functions, so both the original and your proposed code
is rather pointless as an optimization, except for extern declarations.

I'd rather remove the 'const' completely where it causes warnings for
inline functions.

	Arnd <><

