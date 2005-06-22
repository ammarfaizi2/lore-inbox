Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262649AbVFVLZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbVFVLZU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 07:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbVFVLZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 07:25:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11282 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262649AbVFVLZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 07:25:14 -0400
Date: Wed, 22 Jun 2005 12:25:06 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Bernd Petrovitsch <bernd@firmix.at>, kbuild-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Pointer cast warnings in scripts/
Message-ID: <20050622122506.A5226@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	Bernd Petrovitsch <bernd@firmix.at>,
	kbuild-devel@lists.sourceforge.net,
	LKML <linux-kernel@vger.kernel.org>
References: <42B7F740.6000807@drzeus.cx> <Pine.LNX.4.61.0506211413570.3728@scrub.home> <42B80AF9.2060708@drzeus.cx> <Pine.LNX.4.61.0506211451040.3728@scrub.home> <42B80F40.8000609@drzeus.cx> <1119359653.18845.55.camel@tara.firmix.at> <42B92D92.7070304@drzeus.cx> <1119434660.2894.47.camel@tara.firmix.at> <42B94786.2010403@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42B94786.2010403@drzeus.cx>; from drzeus-list@drzeus.cx on Wed, Jun 22, 2005 at 01:12:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 01:12:06PM +0200, Pierre Ossman wrote:
> That doesn't really make it a standard though (de facto perhaps). :)
> The odds of all those man pages deviating from the standard is probably
> very low. But unless someone has actually read the damn thing we won't
> know for sure.

You could check the C99 spec of course, which says gives (eg) strcmp as:

               int strcmp(const char *s1, const char *s2);

rmk's rules of char:

1. use char for character strings and individual characters
2. use signed char if your data type relies upon negative char values
3. use unsigned char if your data type does not require negative char
   values, especially if it makes use of the positive values not
   present in the signed char range.

IOW, use signed/unsigned when you need to explicitly state your
requirements, but omit it for true strings and characters.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
