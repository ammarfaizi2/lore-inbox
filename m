Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWCWINq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWCWINq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 03:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbWCWINp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 03:13:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52204 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030205AbWCWINo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 03:13:44 -0500
Subject: Re: [PATCH] hpet header sanitization
From: Arjan van de Ven <arjan@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Clemens Ladisch <clemens@ladisch.de>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
In-Reply-To: <200603222345.45718.arnd@arndb.de>
References: <20060321144607.153d1943.rdunlap@xenotime.net>
	 <200603221118.43853.abergman@de.ibm.com>
	 <20060322111446.GA7675@turing.informatik.uni-halle.de>
	 <200603222345.45718.arnd@arndb.de>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 09:13:40 +0100
Message-Id: <1143101620.3147.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 23:45 +0100, Arnd Bergmann wrote:
> On Wednesday 22 March 2006 12:14, Clemens Ladisch wrote:
> > There isn't any program (except the example in the docs) that uses any
> > of these ioctls, and I'm writing patches to make this device available
> > through portable timer APIs like hrtimer/POSIX clocks/ALSA that are much
> > easier to use besides, so I think it would be a good idea to just
> > schedule these ioctls for removal.
> 
> Ok, in that case I guess all of the header file should be wrapped inside
> #ifdef __KERNEL__. Until now it was not possible to include that header
> file in order to get the ioctl definition. It would be somewhat
> counterproductive to schedule the user interface for removal while at
> the same time making it easier to use it.
> 
> Also, I don't see any user of the ioctl function in the kernel, although
> it's exported. Are there any out-of-tree users?


hmm there used to be (in s390 iirc ;) but now it's a good opportunity
for Adrian to do a cleanup patch for it 

