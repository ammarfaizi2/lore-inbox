Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264464AbTEJSN7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 14:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264465AbTEJSN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 14:13:59 -0400
Received: from almesberger.net ([63.105.73.239]:47371 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S264464AbTEJSN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 14:13:58 -0400
Date: Sat, 10 May 2003 15:26:27 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Ahmed Masud <masud@googgun.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jesse Pollard <jesse@cats-chateau.net>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Terje Eggestad <terje.eggestad@scali.com>
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030510152626.E13069@almesberger.net>
References: <Pine.LNX.4.33.0305100957100.23680-100000@marauder.googgun.com> <1052585430.1367.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052585430.1367.6.camel@laptop.fenrus.com>; from arjanv@redhat.com on Sat, May 10, 2003 at 06:50:31PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> The only solution for this is to check/audit/log things after the ONE
> copy. Eg not by overriding the syscall but inside the syscall.

Well, not exactly the _only_ one. Inferior alternatives include

 - tracking all user memory accesses, and protecting those pages
   against modifications by other processes (but this adds a
   deadlock risk)

 - like above, but copy all such data to/from a user space area
   that is then protected

 - like above, but use kernel space instead, then use
   set_fs(KERNEL_DS)

Which probably just proves that there are always more painful ways
to do things :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
