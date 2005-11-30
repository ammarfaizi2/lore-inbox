Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbVK3Ltv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbVK3Ltv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 06:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbVK3Ltv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 06:49:51 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:56759 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751161AbVK3Ltu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 06:49:50 -0500
Date: Wed, 30 Nov 2005 12:49:50 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kenneth Parrish <Kenneth.Parrish@familynet-international.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051130114950.GB25101@wohnheim.fh-wedel.de>
References: <203b12.713227@familynet-international.net> <m14q5ufmvi.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m14q5ufmvi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 November 2005 03:31:13 -0700, Eric W. Biederman wrote:
> Kenneth Parrish <Kenneth.Parrish@familynet-international.net> writes:
> 
> > -=> In article 16 Nov 05  14:40:16, Adrian Bunk wrote to All <=-
> >
> >  AB> If one function calls another function you have to add the stack
> >  AB> usages.
> >
> > these few may do that, i bet.
> >  0xc02bb528 huft_build:                                  1432
> >  0xc02bb954 huft_build:                                  1432
> >  0xc02bc1c4 inflate_dynamic:                             1312
> >  0xc02bc2ff inflate_dynamic:                             1312
> >  0xc02bc082 inflate_fixed:                               1168
> >  0xc02bc172 inflate_fixed:                               1168
> 
> Now what is interesting is these functions currently run with a 4KiB 
> stack on every bootup.  So unless they have callers with a
> significant stack footprint things are fine.

The longest call chain for these functions eats roughly 3.2k on i386
with allyesconfig.  Measured with a statical code checker, not tested.

Jörn

-- 
Simplicity is prerequisite for reliability.
-- Edsger W. Dijkstra
