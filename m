Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbVLLPII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbVLLPII (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 10:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbVLLPII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 10:08:08 -0500
Received: from adsl-80.mirage.euroweb.hu ([193.226.228.80]:21509 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1750730AbVLLPIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 10:08:07 -0500
To: schwab@suse.de
CC: ebiederm@xmission.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       pj@sgi.com, rth@twiddle.net, davej@redhat.com, zwane@arm.linux.org.uk,
       ak@suse.de, ashok.raj@intel.com
In-reply-to: <jepso2752o.fsf@sykes.suse.de> (message from Andreas Schwab on
	Mon, 12 Dec 2005 15:39:11 +0100)
Subject: Re: [PATCH] move pm_power_off and pm_idle declaration to common code
References: <E1EloGS-0005gf-00@dorka.pomaz.szeredi.hu>
	<m1pso29z37.fsf@ebiederm.dsl.xmission.com>
	<E1Elof7-0005j7-00@dorka.pomaz.szeredi.hu> <jepso2752o.fsf@sykes.suse.de>
Message-Id: <E1Elox7-0005lf-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 12 Dec 2005 15:46:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> Does powerpc still build?  A key question is how do we handle architectures
> >> that always want to want to call machine_power_off.
> >
> > I didn't (and can't) check, but it should.  IIRC multiple declaration
> > of a variable is OK, as long as at most one has an initializer.
> 
> And as long as you don't build with -fno-common.

That seals the argument, since -fno-common is in linux/Makefile.

So the patch wants fixing on powerpc, but I don't feel up to the task.

Somebody with better knowledge of that arch?

Miklos
