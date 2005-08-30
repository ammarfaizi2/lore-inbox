Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbVH3QGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbVH3QGh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 12:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbVH3QGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 12:06:37 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29090 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932192AbVH3QGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 12:06:36 -0400
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386, x86_64 Initial PAT implementation
References: <m1psrwmg10.fsf@ebiederm.dsl.xmission.com>
	<1125413136.8276.14.camel@localhost.localdomain>
	<m14q97qwng.fsf@ebiederm.dsl.xmission.com>
	<200508301748.50941.ak@suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 30 Aug 2005 10:06:07 -0600
In-Reply-To: <200508301748.50941.ak@suse.de> (Andi Kleen's message of "Tue,
 30 Aug 2005 17:48:50 +0200")
Message-ID: <m1r7cbpfyo.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Tuesday 30 August 2005 17:20, Eric W. Biederman wrote:
>
>> Right.  To the best of my understanding problem aliases are either
>> uncached/write-back or write-combine/write-back.  I don't think
>> uncached/write-combine can cause problems.  My basic reason for
>
> Well it can if one driver expects the mapping to be uncached and the
> other to be WC. The WC one might blast over the other one badly.
>
> Also the architecture defines all attribute conflicts to be undefined
> and it's better to not rely on undefined behaviour because that could
> break quite badly on a future microarchitecture.

Agreed.  It is better.  

My assessment was only to show that the immediate danger of data
corruption or problems isn't very high, even if someone does goof.

Eric

