Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261323AbSJCVtI>; Thu, 3 Oct 2002 17:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261335AbSJCVtI>; Thu, 3 Oct 2002 17:49:08 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:28147 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261323AbSJCVtI>; Thu, 3 Oct 2002 17:49:08 -0400
Subject: Re: export of sys_call_table
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: bidulock@openss7.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021003153943.E22418@openss7.org>
References: <20021003153943.E22418@openss7.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Oct 2002 23:02:40 +0100
Message-Id: <1033682560.28850.32.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-03 at 22:39, Brian F. G. Bidulock wrote:
> I see that RH, in their infinite wisdom, have seen fit to remove
> the export of sys_call_table in 8.0 kernels breaking any loadable
> modules that wish to implement non-implemented system calls such
> as LiS's or iBCS implementation of putmsg/getmsg.

Overwriting syscall table entries is not safe. Its not safe because
there is no locking mechanism, and its not safe because of the pentium
III errata.

> Until now, loadable modules have been able to just overwrite
> the non implemented point in the sys_call_table when they load
> and putting it back when they unload.  There is no mechanism
> for registering system calls.

Not actually safely implementable. The right way to do this is a
relevant 2.5 question. In general however you shouldnt need to register
syscalls because the upper layer interfaces already exist (the LiS stuff
is an example otherwise I grant). 

Alan

