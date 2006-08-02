Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWHBDKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWHBDKl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 23:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWHBDKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 23:10:41 -0400
Received: from cantor.suse.de ([195.135.220.2]:5865 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751098AbWHBDKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 23:10:39 -0400
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 2/33] i386: define __pa_symbol
Date: Wed, 2 Aug 2006 05:04:17 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com> <p73lkq81djg.fsf@verdi.suse.de> <m14pwvyj4m.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m14pwvyj4m.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608020504.17969.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes.  ISO C only defines pointer arithmetic with in arrays.  
> I believe gnu C makes it a well defined case.

Nope, it doesn't.

There was a miscompilation on PPC some time ago, that is why
HIDE_RELOC() and __pa_symbol() was implemented.

> 
> Currently we do not appear to have any problems on i386.
> But I have at least one case of code that is shared between
> i386 and x86_64 and it is appropriate to use __pa_symbol on
> x86_64.
> 
> So I added __pa_symbol for that practical reason.
> 
> I would have no problems with generalizing this but I wanted to
> at least make it possible to use the concept on i386.

No problem with that, just use HIDE_RELOC

-Andi
