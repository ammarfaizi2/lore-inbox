Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbULEHJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbULEHJt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 02:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbULEHJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 02:09:49 -0500
Received: from 70-56-133-193.albq.qwest.net ([70.56.133.193]:33725 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261269AbULEHJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 02:09:48 -0500
Date: Sun, 5 Dec 2004 00:08:57 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] NX: Fix noexec kernel parameter / x86_64
In-Reply-To: <20041205065921.GA26964@elte.hu>
Message-ID: <Pine.LNX.4.61.0412050007010.6378@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0412041135570.6378@montezuma.fsmlabs.com>
 <Pine.LNX.4.61.0412042356340.6378@montezuma.fsmlabs.com> <20041205065921.GA26964@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Dec 2004, Ingo Molnar wrote:

> 
> * Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
> 
> > +		if (!memcmp(from, "noexec=", 7)) {
> > +			extern void nonx_setup(char *str);
> > +	
> > +			nonx_setup(from + 7);
> > +		}
> 
> looks good, but please put the prototype into a header.

I bet Andrew is going to say the same thing... It just seems odd putting a 
prototype in a header for a function with one call site and gets freed 
after boot. Since i'll have to rediff, i'm also going to change the 
nonx_setup parameter type to const char * as suggested by someone in a 
private email.

Thanks,
	Zwane

