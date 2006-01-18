Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbWARIO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbWARIO1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 03:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbWARIO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 03:14:26 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:58592 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S964898AbWARIOZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 03:14:25 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 18 Jan 2006 00:14:18 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@localhost.localdomain
To: David Woodhouse <dwmw2@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>
Subject: Re: [PATCH] pepoll_wait ...
In-Reply-To: <1137570528.30084.29.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.63.0601180010450.4942@localhost.localdomain>
References: <Pine.LNX.4.63.0601171933400.15529@localhost.localdomain> 
 <43CDC21C.7050608@redhat.com> <20060117210318.1f4212f0.akpm@osdl.org> 
 <Pine.LNX.4.63.0601172338530.4942@localhost.localdomain>
 <1137570528.30084.29.camel@localhost.localdomain>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2006, David Woodhouse wrote:

> On Tue, 2006-01-17 at 23:40 -0800, Davide Libenzi wrote:
>> Hey, I've written in the comments that it depends on the
>> TIF_RESTORE_SIGMASK bits ;) The latest one that dwmw posted used such
>> feature, so I though to align epoll bits to that too.
>
> The point is that TIF_RESTORE_SIGMASK needs to be implemented for each
> architecture, and we only have it for powerpc, i386 and FR-V at the
> moment. So in _generic_ files you have to use #ifdef TIF_RESTORE_SIGMASK
> for now, until the other architectures catch up.

Ok, will do. You then let me know when all archs are aligned so that I can 
nuke the #ifdef and use TIF_RESTORE_SIGMASK.


- Davide


