Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261804AbSJQFG5>; Thu, 17 Oct 2002 01:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261802AbSJQFG4>; Thu, 17 Oct 2002 01:06:56 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:49694 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261801AbSJQFGy>; Thu, 17 Oct 2002 01:06:54 -0400
Date: Thu, 17 Oct 2002 01:13:08 -0400
From: Doug Ledford <dledford@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
       linux-scsi@vger.kernel.org
Subject: Re: 2.5.43 IO-APIC bug and spinlock deadlock
Message-ID: <20021017051308.GA10276@redhat.com>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	linux-scsi@vger.kernel.org
References: <20021017033302.GP8159@redhat.com> <20021017042851.GQ8159@redhat.com> <3DAE3F38.11C9E4F1@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAE3F38.11C9E4F1@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 09:40:24PM -0700, Andrew Morton wrote:
> Doug Ledford wrote:
> > 
> > On Wed, Oct 16, 2002 at 11:33:02PM -0400, Doug Ledford wrote:
> > > IO-APIC bug: regular kernel, UP, no IO-APIC or APIC on UP enabled, compile
> > > fails (does *everyone* run SMP or at least UP + APIC now?)
> > 
> > OK, this is real.
> > 
> 
> Linus has merged a patch for this.  Does it work for you?  I don't
> think you've sent us any error output.
> 
> 
>  include/asm-i386/apic.h |    4 ++--
>  include/asm-i386/smp.h  |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

No, tried that, didn't work.  Turn off SMP in your config and also turn 
off APIC support entirely, that's when it breaks the compile.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
