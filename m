Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVAWAwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVAWAwQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 19:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVAWAwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 19:52:16 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:3077
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261171AbVAWAwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 19:52:13 -0500
Date: Sun, 23 Jan 2005 01:52:13 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Rik van Riel <riel@redhat.com>
Cc: Andrea Arcangeli <andrea@cpushare.com>, Pavel Machek <pavel@ucw.cz>,
       Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: seccomp for 2.6.11-rc1-bk8
Message-ID: <20050123005213.GK7587@dualathlon.random>
References: <20050121093902.O469@build.pdx.osdl.net> <Pine.LNX.4.61.0501211338190.15744@chimarrao.boston.redhat.com> <20050121105001.A24171@build.pdx.osdl.net> <20050121195522.GA14982@elte.hu> <20050121203425.GB11112@dualathlon.random> <20050122103242.GC9357@elf.ucw.cz> <20050122172542.GF7587@dualathlon.random> <20050122194242.GB21719@elf.ucw.cz> <20050122233418.GH7587@dualathlon.random> <Pine.LNX.4.61.0501221943050.7152@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501221943050.7152@chimarrao.boston.redhat.com>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2005 at 07:43:26PM -0500, Rik van Riel wrote:
> On Sun, 23 Jan 2005, Andrea Arcangeli wrote:
> 
> >I'm doing something that requires the maximum level of
> >security ever,
> 
> You're kidding, right ?

Why should I be kidding? The client code I'm doing, has to be at least as secure
as ssh and the firewall code, what else has to be more secure than that?
Nor ssh nor the firewall code depends on ptrace for their security. The
nice thing is that I can embed all the security in the kernel with
seccomp, and I'd be a fool not trying it to get it merged and to
complicate my life with ptrace.

Once seccomp is in, I believe there's a chance that security people uses
it for more than Cpushare while I don't think there's a chance you'll
see security people using ptrace_syscall hardcoding the syscall numbers
in every userland app out there that may have to parse untrusted data
with potentially buggy bytecode (i.e. decompression bytecode etc..).
