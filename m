Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVAVXeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVAVXeW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 18:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVAVXeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 18:34:21 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:44635
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261160AbVAVXeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 18:34:19 -0500
Date: Sun, 23 Jan 2005 00:34:18 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: seccomp for 2.6.11-rc1-bk8
Message-ID: <20050122233418.GH7587@dualathlon.random>
References: <20050121100606.GB8042@dualathlon.random> <20050121120325.GA2934@elte.hu> <20050121093902.O469@build.pdx.osdl.net> <Pine.LNX.4.61.0501211338190.15744@chimarrao.boston.redhat.com> <20050121105001.A24171@build.pdx.osdl.net> <20050121195522.GA14982@elte.hu> <20050121203425.GB11112@dualathlon.random> <20050122103242.GC9357@elf.ucw.cz> <20050122172542.GF7587@dualathlon.random> <20050122194242.GB21719@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050122194242.GB21719@elf.ucw.cz>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2005 at 08:42:42PM +0100, Pavel Machek wrote:
> Well, then you can help auditing ptrace()... It is probably also true
> that more people audited ptrace() than seccomp :-).

Why should I spend time auditing ptrace when I have a superior solution
that doesn't require me any auditing at all? I've an huge pile of work,
I'm not doing this for fun, just thinking at wasting time auditing a
single line of ptrace code is insane as far as I'm concerned (if I can
avoid it with a more robust, less likely to break and simpler approach).
If the l-k community forces me to use ptrace, I'll be forced to do that
indeed (and you should be ready to take the blame if something goes
wrong), but be sure I'll try as much as I can to stay away from ptrace
completely.  ptrace is a debugging knob, uml itself is a debugging tool
that depends on a debugging knob and that's fine. I'm not doing a
debugging tool, I'm doing something that requires the maximum level of
security ever, and using ptrace is dead wrong for that IMHO.
