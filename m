Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWDLRDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWDLRDi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 13:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWDLRDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 13:03:37 -0400
Received: from ns.suse.de ([195.135.220.2]:47056 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932221AbWDLRDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 13:03:37 -0400
To: Kirill Korotaev <dev@sw.ru>
Cc: Kir Kolyshkin <kir@openvz.org>, akpm@osdl.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, sam@vilain.net,
       linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>, serue@us.ibm.com,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, herbert@13thfloor.at
Subject: Re: [Devel] Re: [RFC] Virtualization steps
References: <1143228339.19152.91.camel@localhost.localdomain>
	<200603282029.AA00927@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
	<4429A17D.2050506@openvz.org> <443151B4.7010401@tmr.com>
	<443B873B.9040908@sw.ru> <p73mzer4bti.fsf@bragg.suse.de>
	<443CA47E.4070809@sw.ru> <p73irpf473y.fsf@bragg.suse.de>
	<443CB181.40008@sw.ru>
From: Andi Kleen <ak@suse.de>
Date: 12 Apr 2006 19:03:24 +0200
In-Reply-To: <443CB181.40008@sw.ru>
Message-ID: <p738xqa4tgj.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:
> 
> -------------- cut ---------------
> Changing PAGE_OFFSET this way would break at least Valgrind (the latest
> release 3.1.0 by default is statically linked at address 0xb0000000, and
> PIE support does not seem to be present in that release).  I remember
> that similar changes were also breaking Lisp implementations (cmucl,
> sbcl), however, I am not really sure about this.
> -------------- cut ---------------

valgrind only breaks when you decrease TASK_SIZE to 2GB, not when you
enlarge it. In general 2GB VM breaks a lot of apps, that is why
the new CONFIGs that were added for this were a very bad idea imho.

Obviously the x86-64 kernel doesn't support such things.

> Also, why would one expect 4GB of VM on x86-64 if normally have 3GB on
> i686? Anyway, as it is tunable, people can select which one they
> prefer.

Because near all programs that need can actually take advance of it.

-Andi

