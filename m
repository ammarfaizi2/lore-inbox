Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbWFUJ0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbWFUJ0L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 05:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbWFUJ0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 05:26:11 -0400
Received: from ns2.suse.de ([195.135.220.15]:27579 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932505AbWFUJ0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 05:26:09 -0400
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC, patch] i386: vgetcpu(), take 2
References: <200606210329_MC3-1-C305-E008@compuserve.com>
From: Andi Kleen <ak@suse.de>
Date: 21 Jun 2006 11:26:06 +0200
In-Reply-To: <200606210329_MC3-1-C305-E008@compuserve.com>
Message-ID: <p73zmg6oo5t.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> writes:

> Use a GDT entry's limit field to store per-cpu data for fast access
> from userspace, and provide a vsyscall to access the current CPU
> number stored there.

Just the CPU alone is useless - you want at least the node too in many
cases. Best you use the prototype I proposed earlier for x86-64.

-Andi
