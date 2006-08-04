Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWHDGJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWHDGJX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 02:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWHDGJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 02:09:22 -0400
Received: from ns.suse.de ([195.135.220.2]:31719 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751175AbWHDGJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 02:09:21 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: entry.s::error_code is not safe for kprobes
Date: Fri, 4 Aug 2006 08:08:22 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <200608030623_MC3-1-C6F0-24AD@compuserve.com>
In-Reply-To: <200608030623_MC3-1-C6F0-24AD@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608040808.22385.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 August 2006 12:20, Chuck Ebbert wrote:
> Because code marked unsafe for kprobes jumps directly to
> entry.S::error_code, that must be marked unsafe as well.
> The easiest way to do that is to move the page fault entry
> point to just before error_code and let it inherit the same
> section.
> 
> Also moved all the ".previous" asm directives for kprobes
> sections to column 1 and removed ".text" from them.

Ok added thanks

-Andi
