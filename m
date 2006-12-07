Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163198AbWLGSnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163198AbWLGSnW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 13:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163196AbWLGSnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 13:43:22 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:63865 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163183AbWLGSnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 13:43:21 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jan Glauber <jan.glauber@de.ibm.com>
Subject: Re: [RFC][PATCH] Pseudo-random number generator
Date: Thu, 7 Dec 2006 19:43:13 +0100
User-Agent: KMail/1.9.5
Cc: linux-crypto <linux-crypto@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <1164979155.5882.23.camel@bender> <200612071606.33951.arnd@arndb.de> <1165504796.5607.17.camel@bender>
In-Reply-To: <1165504796.5607.17.camel@bender>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612071943.14153.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 December 2006 16:19, Jan Glauber wrote:
> Hm, why is /dev/urandom implemented in the kernel?
> 
> It could be done completely in user-space (like libica already does)
> but I think having a device node where you can read from is the simplest
> implementation. Also, if we can solve the security flaw we could use it
> as replacement for /dev/urandom.

urandom is more useful, because can't be implemented in user space at
all. /dev/urandom will use the real randomness from the kernel as a seed
without depleting the entropy pool. How does your /dev/prandom device
compare to /dev/urandom performance-wise? If it can be made to use
the same input data and it turns out to be significantly faster, I can
see some use for it.

	Arnd <><
