Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751786AbWD2HIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbWD2HIb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 03:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbWD2HIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 03:08:31 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:14071 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751786AbWD2HIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 03:08:30 -0400
Date: Sat, 29 Apr 2006 09:08:26 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Heiko J Schick <info@schihei.de>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       Michael Ellerman <michael@ellerman.id.au>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, linuxppc-dev@ozlabs.org,
       Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
Subject: Re: [openib-general] Re: [PATCH 04/16] ehca: userspace support
Message-ID: <20060429070826.GA9463@osiris.boeblingen.de.ibm.com>
References: <4450A176.9000008@de.ibm.com> <20060427114355.GB32127@wohnheim.fh-wedel.de> <1146177388.19236.1.camel@localhost.localdomain> <6C4A3B96-4752-4FF9-8FBE-C383B00AE014@schihei.de> <84144f020604272332s6101032cy6936096230f3637c@mail.gmail.com> <4044CACC-FB5A-415E-8974-27136269B5C1@schihei.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4044CACC-FB5A-415E-8974-27136269B5C1@schihei.de>
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>The problem I see with pr_debug() is that it could only activated via
> >>a compile flag. To use the debug outputs you have to re-compile /
> >>compile your own kernel.
> >
> >Do you really need this heavy debug logging in the first place? You
> >can use kprobes for arbitrary run-time inspection anyway, so logging
> >everything seems wasteful.
> 
> The problem I see with kprobes is that you have to set several kernel
> configuration options (e.g. CONFIG_KPROBES, CONFIG_DEBUG_INFO, etc.)
> on compile time to use it. Same problem with pr_debug().

It might be worth to move the s390 debug feature to common code. At least
it has proven many times to be very useful in device driver debugging...
See Documentation/s390/s390dbf.txt and arch/s390/kernel/debug.c.
