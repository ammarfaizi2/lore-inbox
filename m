Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032330AbWLGP4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032330AbWLGP4q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 10:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032335AbWLGP4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 10:56:46 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:11744 "EHLO
	mtagate1.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032330AbWLGP4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 10:56:45 -0500
Subject: Re: [RFC][PATCH] Pseudo-random number generator
From: Jan Glauber <jan.glauber@de.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-crypto <linux-crypto@vger.kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200612071606.33951.arnd@arndb.de>
References: <1164979155.5882.23.camel@bender>
	 <200612071606.33951.arnd@arndb.de>
Content-Type: text/plain
Date: Thu, 07 Dec 2006 16:19:56 +0100
Message-Id: <1165504796.5607.17.camel@bender>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-07 at 16:06 +0100, Arnd Bergmann wrote:
> On Friday 01 December 2006 14:19, Jan Glauber wrote:
> > I've chosen the char driver since it allows the user to decide which pseudo-random
> > numbers he wants to use. That means there is a new interface for the s390
> > PRNG, called /dev/prandom.
> > 
> > I would like to know if there are any objections, especially with the chosen device
> > name.
> 
> This may be a stupid question, but what is it _good_ for? My understanding is
> that the crypt_s390_kmc() opcodes work in user mode as well as kernel mode, so
> you should not need a character device at all, but maybe just a small tool
> that spits prandom data to stdout.

Hm, why is /dev/urandom implemented in the kernel?

It could be done completely in user-space (like libica already does)
but I think having a device node where you can read from is the simplest
implementation. Also, if we can solve the security flaw we could use it
as replacement for /dev/urandom.

Jan

