Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWCOJMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWCOJMH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 04:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbWCOJMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 04:12:07 -0500
Received: from javad.com ([216.122.176.236]:30227 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S1751070AbWCOJMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 04:12:06 -0500
From: Sergei Organov <osv@javad.com>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #4]
References: <878xrecypp.fsf@javad.com>
	<16835.1141936162@warthog.cambridge.redhat.com>
	<31079.1142368507@warthog.cambridge.redhat.com>
Date: Wed, 15 Mar 2006 12:11:57 +0300
In-Reply-To: <31079.1142368507@warthog.cambridge.redhat.com> (David
 Howells's
	message of "Tue, 14 Mar 2006 20:35:07 +0000")
Message-ID: <877j6wax7m.fsf@javad.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> Sergei Organov <osv@javad.com> wrote:
>
>> > +In addition, accesses to "volatile" memory locations and volatile asm
>> > +statements act as implicit compiler barriers.
>> 
>> This last statement seems to contradict with what GCC manual says about
>> volatile asm statements:
>
> Perhaps I should say "compiler memory barrier", since it doesn't prevent
> instructions from being moved, but rather merely affects the ordering of
> memory accesses and volatile instructions.

Well, I'd just remove the two lines in question as neither volatile
access nor volatile asm are barriers, -- that's why the barrier() is
needed in the first place.

-- Sergei.
