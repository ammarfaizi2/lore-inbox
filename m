Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbUKBOJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbUKBOJc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 09:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbUKBN7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 08:59:12 -0500
Received: from cantor.suse.de ([195.135.220.2]:49126 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261448AbUKBMpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 07:45:13 -0500
To: "Jin, Gordon" <gordon.jin@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64]: Setup PER_LINUX32 on x86_64
References: <8126E4F969BA254AB43EA03C59F44E84BBECA2@pdsmsx404.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 02 Nov 2004 12:34:15 +0100
In-Reply-To: <8126E4F969BA254AB43EA03C59F44E84BBECA2@pdsmsx404.suse.lists.linux.kernel>
Message-ID: <p73breg8oy0.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jin, Gordon" <gordon.jin@intel.com> writes:

> On x86_64, PER_LINUX32 is not setup but used by syscall personality and uname.
> This patch sets PER_LINUX32 when x86 binary loaded so it can be used correctly.
> - Set personality to PER_LINUX32 when x86 binary loaded.
> - Set personality to PER_LINUX when x86_64 binary loaded.
> - Use sys32_personality instead of sys_personality.
> - Add sys32_newuname() for syscall newuname.
> - Remove the unnecessary check for PER_LINUX32 in sys_uname().

Rejected. This was separated intentionally. Otherwise 
e.g. you can never get x86_64 out of uname with a 32bit uname.

-Andi

 
