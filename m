Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310305AbSCGMu3>; Thu, 7 Mar 2002 07:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310309AbSCGMuT>; Thu, 7 Mar 2002 07:50:19 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:14832 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S310305AbSCGMuJ>; Thu, 7 Mar 2002 07:50:09 -0500
Message-ID: <3C8761FF.A10E50D9@redhat.com>
Date: Thu, 07 Mar 2002 12:50:07 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-26beta.16smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: furwocks: Fast Userspace Read/Write Locks
In-Reply-To: <E16iwkE-000216-00@wagner.rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> This is a userspace implementation of rwlocks on top of futexes.

question: if rwlocks aren't actually slower in the fast path than
futexes,
would it make sense to only do the rw variant and in some userspace
layer
map "traditional" semaphores to write locks ?
Saves half the implementation and testing....
