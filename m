Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbVLCSDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbVLCSDt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 13:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbVLCSDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 13:03:49 -0500
Received: from ns2.suse.de ([195.135.220.15]:38607 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932111AbVLCSDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 13:03:48 -0500
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Vinay Venkataraghavan <raghavanvinay@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: copy_from_user/copy_to_user question
References: <20051202224025.39396.qmail@web32108.mail.mud.yahoo.com>
	<1133572199.32583.93.camel@localhost.localdomain>
	<20051203013833.GG27946@ftp.linux.org.uk>
	<1133575346.4894.7.camel@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 03 Dec 2005 15:33:02 -0700
In-Reply-To: <1133575346.4894.7.camel@localhost.localdomain>
Message-ID: <p73lkz14xr5.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:
> 
> I haven't dealt (yet) with the copy_user of x86_64.  Is there a problem
> when one tries to copy to/from a 32 bit address while in a 64 bit
> address space?

No problem, except on UML/x86-64 which has fully separate address spaces.

Architectures where it doesn't work include s390,m68k,pa-risc,sparc64,
i386 with 4/4 patches among others.

-Andi
