Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263752AbUEMFRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbUEMFRJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 01:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUEMFRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 01:17:09 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:60426 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263752AbUEMFRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 01:17:07 -0400
Date: Thu, 13 May 2004 07:05:15 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       davidm@hpl.hp.com, rddunlap@osdl.org, ebiederm@xmission.com,
       drepper@redhat.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: [announce] kexec for linux 2.6.6
Message-ID: <20040513050515.GA578@alpha.home.local>
References: <40A243C8.401@redhat.com> <m1brktod3f.fsf@ebiederm.dsl.xmission.com> <40A2517C.4040903@redhat.com> <m17jvhoa6g.fsf@ebiederm.dsl.xmission.com> <20040512143233.0ee0405a.rddunlap@osdl.org> <16546.41076.572371.307153@napali.hpl.hp.com> <20040512152815.76280eac.akpm@osdl.org> <16546.42537.765495.231960@napali.hpl.hp.com> <20040512161603.44c50cec.akpm@osdl.org> <20040513053051.A5286@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513053051.A5286@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 05:30:52AM +0100, Christoph Hellwig wrote:
> On Wed, May 12, 2004 at 04:16:03PM -0700, Andrew Morton wrote:
> > But if we need additional infrastructure to "add new syscalls via VDSO" then
> > this should be in the base kernel, even if it's empty, yes?
> 
> Linus has vetoed dynamic syscall registration a few times.  And I agree
> with him, dynamic syscalls are the best way to get completely crappy
> interfaces.

And why not definitely assign sort of a "multiplexed syscall" entry,
a la sys_socketcall() ? It could be shared by lots of non-mainline projects
and have a greater chance of being stable along the time.

Cheers,
Willy

