Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267250AbUG1QAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267250AbUG1QAG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 12:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267254AbUG1P7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 11:59:09 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44983 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S267250AbUG1P5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 11:57:16 -0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, suparna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fastboot@osdl.org
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
References: <16734.1090513167@ocs3.ocs.com.au>
	<20040725235705.57b804cc.akpm@osdl.org>
	<m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
	<20040728105455.GA11282@in.ibm.com>
	<1091011565.30404.0.camel@localhost.localdomain>
	<35040000.1091025526@[10.10.2.4]>
	<1091023585.30740.7.camel@localhost.localdomain>
	<120130000.1091028085@[10.10.2.4]>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Jul 2004 09:56:31 -0600
In-Reply-To: <120130000.1091028085@[10.10.2.4]>
Message-ID: <m1658815xs.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> --Alan Cox <alan@lxorguk.ukuu.org.uk> wrote (on Wednesday, July 28, 2004
> 15:06:27 +0100):
> 
> 
> > On Mer, 2004-07-28 at 15:38, Martin J. Bligh wrote:
> >> After kexec, we shouldn't need such things, do we? Before it, Linus won't 
> >> take the patch, as he said he doesn't like systems in unstable states doing
> >> crashdumps to disk ...
> > 
> > And what does kexec do.. it accesses the disk. A SHA signed standalone
> > dumper is as safe as anything else if not safer.
> 
> But it's reading, not writing ... personally I'm happier with that bit ;-)

And it is only reading to preload the dumper in memory.  This happens
before the system crashes.

All that happens at crash dump time is we hand off control to the dumper.
kexec is just the mechanism to switch from the kernel to the dumper.

It is attractive to make the dumper based on the current linux kernel
but that is by no means a requirement.

Eric
