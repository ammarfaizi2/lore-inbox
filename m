Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316912AbSFZVib>; Wed, 26 Jun 2002 17:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316928AbSFZVia>; Wed, 26 Jun 2002 17:38:30 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:59778 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316912AbSFZVi3>; Wed, 26 Jun 2002 17:38:29 -0400
Date: Wed, 26 Jun 2002 16:37:55 -0500
From: Amos Waterland <apw@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Cc: Tom Gall <tom_gall@vnet.ibm.com>
Subject: Re: O_ASYNC question
Message-ID: <20020626163755.A10713@kvasir.austin.ibm.com>
References: <20020625113052.A7510@kvasir.austin.ibm.com> <20020626211122.GL22961@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020626211122.GL22961@holomorphy.com>; from wli@holomorphy.com on Wed, Jun 26, 2002 at 02:11:22PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2002 at 02:11:22PM -0700, William Lee Irwin III wrote:
> On Tue, Jun 25, 2002 at 11:30:52AM -0500, Amos Waterland wrote:
> > The man page for fcntl() says:
> >     If you set the O_ASYNC status flag on a file descriptor (either by
> >     providing this flag with the open(2) call, or by using the F_SETFL
> >     command of fcntl), a SIGIO signal is sent whenever input or output
> >     becomes possible on that file descriptor.
> 
> Not done for files and you need fsetown() for sockets and tty's.

Thanks for the reply.

The reason that I was interested is that this behavior, if implemented
for all fd types, would be useful for a scalable user-space
implementation of POSIX aio.

When you say that it is 'not done for files', does that mean that it is
not done by design, and no plans exist to implement it for files
(perhaps because completion notification is fundamentally different than
readiness notification?), or that the work just has yet to be done?
Thanks.

Amos W.
