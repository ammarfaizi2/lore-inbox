Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273796AbRKHP3u>; Thu, 8 Nov 2001 10:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273854AbRKHP3l>; Thu, 8 Nov 2001 10:29:41 -0500
Received: from cayuga.grammatech.com ([209.4.89.66]:62476 "EHLO grammatech.com")
	by vger.kernel.org with ESMTP id <S273796AbRKHP32>;
	Thu, 8 Nov 2001 10:29:28 -0500
Message-ID: <3BEAA4CF.3B32515F@grammatech.com>
Date: Thu, 08 Nov 2001 10:29:19 -0500
From: David Chandler <chandler@grammatech.com>
Organization: GrammaTech, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bug Report: Dereferencing a bad pointer
In-Reply-To: <3BE9C261.D7422143@grammatech.com> <20011107184018.A6483@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:

> On Wed, Nov 07, 2001 at 06:23:13PM -0500, David Chandler wrote:
> > The following one-line C program, when compiled by gcc 2.96 without
> > optimization, should produce a SIGSEGV segmentation fault (on a machine
> > with 3 or less gigabytes of virtual memory, at least):
> >
> >         int main() { int k  = *(int *)0xc0000000; }
> >
> > However, it does not do so under 2.4.x -- it does cause a seg fault
> > under
> > 2.2.x kernels.
>
> Works here running 2.4.13-ac8+bits.  Are you sure you didn't compile with
> optimization enabled?
>
>                 -ben

I'm quite sure -- an optimized build exits immediately, whereas I'm seeing a
hung process with 2.4 kernels that has to be killed (most any signal,
including SIGSEGV, will do the trick).  With 2.2 kernels, the program seg
faults, as it should.  By "Works here" I assume you mean that you received a
segmentation fault.

I get the same result with gcc 3.0.1 and gcc 2.96 (and yes, the relevant
generated code differs slightly).  I have tried Linus's official 2.4.13+UML
on UML, but I've not tried 2.4.13-ac8.

Please Cc: me on any replies.


David Chandler

_____
David L. Chandler.                              GrammaTech, Inc.
mailto:chandler@grammatech.com         http://www.grammatech.com



