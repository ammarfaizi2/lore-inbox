Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265615AbSIRHAy>; Wed, 18 Sep 2002 03:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265711AbSIRHAx>; Wed, 18 Sep 2002 03:00:53 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:62997 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265615AbSIRHAx>; Wed, 18 Sep 2002 03:00:53 -0400
Date: Wed, 18 Sep 2002 03:05:23 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Dan Kegel <dank@kegel.com>, linux-kernel@vger.kernel.org
Subject: Re: Hardware limits on numbers of threads?
Message-ID: <20020918030523.D12870@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <3D88208E.8545AAA2@kegel.com> <200209180643.g8I6hBp29508@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209180643.g8I6hBp29508@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Wed, Sep 18, 2002 at 09:37:58AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 09:37:58AM -0200, Denis Vlasenko wrote:
> On 18 September 2002 04:43, Dan Kegel wrote:
> > http://people.redhat.com/drepper/glibcthreads.html says:
> > > Hardware restrictions put hard limits on the number of
> > > threads the kernel can support for each process.
> > > Specifically this applies to IA-32 (and AMD x86_64) where the thread
> > > register is a segment register. The processor architecture
> > > puts an upper limit on the number of segment register values
> > > which can be used (8192 in this case).
> >
> > Is this true?  Where does the limit come from?
> 
> It is true that on x86 you have only 8192 different segment selectors
> at a time. Nobody says you can't modify segment descriptors on demand.
> 
> If I'm not mistaken, Linux kernel does precisely this. It has per-CPU
> allocated GDT entries, not per-task.

That page has been written way before set_thread_area(2) (and other kernel
threading changes) were written.

	Jakub
