Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317457AbSHLHWj>; Mon, 12 Aug 2002 03:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317462AbSHLHWj>; Mon, 12 Aug 2002 03:22:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40813 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S317457AbSHLHWi>; Mon, 12 Aug 2002 03:22:38 -0400
To: Keith Owens <kaos@ocs.com.au>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Unix-domain sockets - abstract addresses
References: <1716.1029124644@kao2.melbourne.sgi.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 Aug 2002 01:13:28 -0600
In-Reply-To: <1716.1029124644@kao2.melbourne.sgi.com>
Message-ID: <m1d6sor1lz.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> writes:

> On Sun, 11 Aug 2002 20:13:14 -0700 (PDT), 
> "David S. Miller" <davem@redhat.com> wrote:
> >   From: Keith Owens <kaos@ocs.com.au>
> >   Date: Mon, 12 Aug 2002 13:20:09 +1000
> >   
> >   The problem here is that 'unix' is
> > ...
> >   a symbol that is defined by gcc.
> >
> >I see.  GCC really shouldn't be doing that as it pollutes the global
> >namespace.  However, I see current 3.x vintage gcc is still doing it
> >under Linux so there must be a reason it is kept around.
> 
> Untested, against 2.5.31.  It would be better to -Uunix globally but
> one header depends on it, drivers/message/fusion/lsi/mpi_type.h.

Additionally a version of stringify that did not expand macros would
also solve this problem.

Eric
