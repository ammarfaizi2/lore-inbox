Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130046AbQJ0Wn7>; Fri, 27 Oct 2000 18:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130712AbQJ0Wnt>; Fri, 27 Oct 2000 18:43:49 -0400
Received: from mail.fluke.com ([206.138.179.200]:18698 "EHLO
	evtvir02.tc.fluke.com") by vger.kernel.org with ESMTP
	id <S130046AbQJ0Wni>; Fri, 27 Oct 2000 18:43:38 -0400
Date: Fri, 27 Oct 2000 15:43:34 -0700 (PDT)
From: David Dyck <dcd@tc.fluke.com>
To: Brian Gerst <bgerst@didntduck.org>
cc: <linux-kernel@vger.kernel.org>, "Barry K. Nathan" <barryn@pobox.com>
Subject: Re: test10-pre5 mount: Unable to handle kernel paging request at 
 virtualaddress
In-Reply-To: <39F66A65.2F9EF34B@didntduck.org>
Message-ID: <Pine.LNX.4.30.0010271541150.470-100000@dd.tc.fluke.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2000, Brian Gerst wrote:

> > On Mon, 23 Oct 2000, David Dyck wrote:
> >
> > > I am getting a repeatable oops during the boot up phase,
> > > with linux 2.4.0  test10-pre4
>
> I know what your problem is now:
>
> > > Gnu C                  2.7.2.3
>
> GCC 2.7.2.3 miscompiles the kernel_module structure.  Since this is
> where the exception table pointers are stored in a modular kernel, the
> page fault handler was failing to find the exception handler and causing
> an oops.

Thanks Brian,  I finally got around to updating the compiler,
and this did fix the problem

My thanks also to Barry for posting the patch to
Documentation/Changes

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
