Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933669AbWKQRpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933669AbWKQRpJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 12:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933597AbWKQRpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 12:45:09 -0500
Received: from homer.mvista.com ([63.81.120.158]:30172 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S933669AbWKQRpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 12:45:08 -0500
Subject: Re: 2.6.19-rc6-rt0, -rt YUM repository
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20061117161742.GA10182@elte.hu>
References: <20061116153553.GA12583@elte.hu>
	 <1163694712.26026.1.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611162212110.21141@frodo.shire>
	 <1163713469.26026.4.camel@localhost.localdomain>
	 <20061116220733.GA17217@elte.hu> <1163779116.6953.38.camel@mindpipe>
	 <20061117161742.GA10182@elte.hu>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 09:44:55 -0800
Message-Id: <1163785495.3097.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-17 at 17:17 +0100, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > On Thu, 2006-11-16 at 23:07 +0100, Ingo Molnar wrote:
> > > * Daniel Walker <dwalker@mvista.com> wrote:
> > > 
> > > > [...] Should we start a known regression list?
> > > 
> > > please resend the bugs that still trigger for you with 2.6.19-rt0.
> > 
> > I'm working with the developers of the 64Studio distro who are 
> > attempting to ship a stable -rt kernel so I have access to lots of 
> > good bug reports.  Oops on boot is by far the most common.  I'll post 
> > details once we've retested with 2.6.19-rt0.
> 
> thanks, please do that. Right now i have no open boot-crash regression 
> left that i can reproduce.


Should we pull in Steve's patch for these, or are you just grabbing
Jeff's tree? I noticed they aren't always commented "shut up gcc"  .

--- linux.orig/arch/i386/kernel/efi.c
+++ linux/arch/i386/kernel/efi.c
@@ -271,7 +271,7 @@ void efi_memmap_walk(efi_freemem_callbac
        struct range {
                unsigned long start;
                unsigned long end;
-       } prev, curr;
+       } prev = { } /* shut up gcc */ , curr = { } /* shut up gcc */ ;
        efi_memory_desc_t *md;
        unsigned long start, end;
        void *p;

