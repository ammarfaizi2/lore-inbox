Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbTA1HUE>; Tue, 28 Jan 2003 02:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267329AbTA1HUE>; Tue, 28 Jan 2003 02:20:04 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28750 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S264938AbTA1HUD>; Tue, 28 Jan 2003 02:20:03 -0500
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: kexec reboot code buffer
References: <3E31AC58.2020802@us.ibm.com> <m1znppco1w.fsf@frodo.biederman.org>
	<3E35AAE4.10204@us.ibm.com> <m1r8ax69ho.fsf@frodo.biederman.org>
	<20030128071826.GI780@holomorphy.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Jan 2003 00:28:04 -0700
In-Reply-To: <20030128071826.GI780@holomorphy.com>
Message-ID: <m1isw968e3.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:

> On Tue, Jan 28, 2003 at 12:04:19AM -0700, Eric W. Biederman wrote:
> > I agree that lowmem for the common case is fine.  For kexec on panic,
> > and a some weird cases using high mem is beneficial.  I don't have
> > a problem with changing it back to just lowmem for the time being.
> 
> Well, there is the bit about dropping the PAE bit from %cr4 too.

Already done, it actually doesn't byte me until the next kernel starts
to execute, as we only set and not clear the PAE bit during bootup.

> Seriously, just plop down the fresh zone type and all will be well.
> It's really incredibly easy.

I will certainly take a look, tracing through that code can get a little
hairy.

Eric
