Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWGLUKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWGLUKK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 16:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWGLUKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 16:10:10 -0400
Received: from terminus.zytor.com ([192.83.249.54]:9636 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750920AbWGLUKI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 16:10:08 -0400
Message-ID: <44B556E5.5000702@zytor.com>
Date: Wed, 12 Jul 2006 13:09:09 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jakub Jelinek <jakub@redhat.com>
CC: Ulrich Drepper <drepper@redhat.com>, Roland McGrath <roland@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
References: <20060712184412.2BD57180061@magilla.sf.frob.com> <44B54EA4.5060506@redhat.com> <20060712195349.GW3823@sunsite.mff.cuni.cz>
In-Reply-To: <20060712195349.GW3823@sunsite.mff.cuni.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek wrote:
> On Wed, Jul 12, 2006 at 12:33:56PM -0700, Ulrich Drepper wrote:
>> Roland McGrath wrote:
>>> We could also put the uname info (modulo nodename) into the vDSO.
>> Or even better: real topology information.
> 
> AND rather than OR would be even better.  So glibc could find kernel
> version, etc. and topology in the vDSO cheaply.

Wouldn't it make more sense for this to be in ELF tags, rather than the 
vdso?  Another alternative, I guess, would be to put a pointer in the 
ELF tags, which may point into the vdso.

	-hpa
