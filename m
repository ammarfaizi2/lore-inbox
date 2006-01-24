Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbWAXAm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWAXAm5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 19:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbWAXAm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 19:42:57 -0500
Received: from ns2.suse.de ([195.135.220.15]:23464 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030250AbWAXAl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 19:41:26 -0500
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 0/9] Shared ia32 syscall table
Date: Tue, 24 Jan 2006 01:41:07 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       Jeff Dike <jdike@addtoit.com>
References: <200601231938_MC3-1-B687-7C42@compuserve.com>
In-Reply-To: <200601231938_MC3-1-B687-7C42@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601240141.08152.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 January 2006 01:36, Chuck Ebbert wrote:
> This patch series updates i386 and x86_64 so they share
> the same ia32 syscall table.  UML already uses the i386
> table and is updated to use the new shared table as well.

That's wrong for x86-64. The IA32 syscall table needs
to point to compat_* version of syscalls, while the native
IA32 table uses sys_* directly.

-Andi
