Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272947AbSISUUV>; Thu, 19 Sep 2002 16:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272936AbSISUUV>; Thu, 19 Sep 2002 16:20:21 -0400
Received: from zero.aec.at ([193.170.194.10]:32785 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S272935AbSISUUU>;
	Thu, 19 Sep 2002 16:20:20 -0400
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org, dank@kegel.com
Subject: Re: Hardware limits on numbers of threads?
References: <3D88208E.8545AAA2@kegel.com> <3D882500.2000105@redhat.com>
From: Andi Kleen <ak@muc.de>
Date: 19 Sep 2002 11:36:11 +0200
In-Reply-To: <3D882500.2000105@redhat.com>
Message-ID: <m3n0qe8gok.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper <drepper@redhat.com> writes:


> This was and is true with the kernel before 2.5.3<mumble> when Ingo
> introduced TLS support since the thread specific data had to be
> addressed via LDT entries and the LDT holds at most 8192 entries.  The
> GDT based solution now implemented in the kernel has no such
> limitation and the number of threads you can create with the new
> thread library is only limited by system resources.

It also was alwas incorrect for x86-64/64bit progreams, which do not 
use a LDT entry for each thread.

-Andi
