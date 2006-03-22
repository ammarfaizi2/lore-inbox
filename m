Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWCVWqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWCVWqZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWCVWqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:46:07 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:45767 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964823AbWCVWqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:46:01 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] hpet header sanitization
Date: Wed, 22 Mar 2006 23:45:44 +0100
User-Agent: KMail/1.9.1
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
References: <20060321144607.153d1943.rdunlap@xenotime.net> <200603221118.43853.abergman@de.ibm.com> <20060322111446.GA7675@turing.informatik.uni-halle.de>
In-Reply-To: <20060322111446.GA7675@turing.informatik.uni-halle.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200603222345.45718.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 12:14, Clemens Ladisch wrote:
> There isn't any program (except the example in the docs) that uses any
> of these ioctls, and I'm writing patches to make this device available
> through portable timer APIs like hrtimer/POSIX clocks/ALSA that are much
> easier to use besides, so I think it would be a good idea to just
> schedule these ioctls for removal.

Ok, in that case I guess all of the header file should be wrapped inside
#ifdef __KERNEL__. Until now it was not possible to include that header
file in order to get the ioctl definition. It would be somewhat
counterproductive to schedule the user interface for removal while at
the same time making it easier to use it.

Also, I don't see any user of the ioctl function in the kernel, although
it's exported. Are there any out-of-tree users?

	Arnd <><
