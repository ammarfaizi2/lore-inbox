Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbTILRco (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 13:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbTILRco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 13:32:44 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39245 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261780AbTILRcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 13:32:43 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, richard.brunner@amd.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
References: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com>
	<20030911012708.GD3134@wotan.suse.de>
	<20030910184414.7850be57.akpm@osdl.org>
	<20030911014716.GG3134@wotan.suse.de> <3F60837D.7000209@pobox.com>
	<20030911162634.64438c7d.ak@suse.de> <3F6087FC.7090508@pobox.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 Sep 2003 11:32:42 -0600
In-Reply-To: <3F6087FC.7090508@pobox.com>
Message-ID: <m1vfrxlxol.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> >> If I disabled CONFIG_X86_GENERIC and select CONFIG_MPENTIUM4, I darned well
> >> better not get any Athlon code.  The cpu setup code in particular I want to
> >> conditionalize, and there are other bits that need work... but for the most
> >> part it works as intended.
> > Now that's becomming silly. It's alttogether only a few KB and all
> > __init code anyways.
> 
> 
> If you're doing crazy LinuxBIOS stuff where flash size is limited, it makes a
> lot of sense.  (and I do such crazy things)  The core 2.6 kernel has really
> bloated with optional features, IMO.

The size of a minimal bzImage (the stuff you can't compile out) has
increased by roughly 400KB since 1.0 200KB since 2.2 and 100KB since 2.4.

So please pardon those of us who complain at things that can't be
configured out.  The x86 kernel is on the edge of becoming useless
in some embedded scenarios because it is so fat.

When we can compile out code, we can at least narrow down where the
problems are.

I have to agree with Jeff the LinuxBIOS stuff is  crippled right now
because of this.

There may be better places to attack.  But new code is what is up for
examination and is easiest to fix.

Eric
