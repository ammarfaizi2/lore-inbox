Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265380AbSJXK2m>; Thu, 24 Oct 2002 06:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265381AbSJXK2m>; Thu, 24 Oct 2002 06:28:42 -0400
Received: from rth.ninka.net ([216.101.162.244]:9117 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S265380AbSJXK2l>;
	Thu, 24 Oct 2002 06:28:41 -0400
Subject: Re: O_DIRECT sockets? (was [RESEND] tuning linux for high network 
	performance?)
From: "David S. Miller" <davem@rth.ninka.net>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Nivedita Singhvi <niv@us.ibm.com>, bert hubert <ahu@ds9a.nl>,
       netdev@oss.sgi.com, Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200210241214.59812.roy@karlsbakk.net>
References: <200210231218.18733.roy@karlsbakk.net>
	<200210231726.21135.roy@karlsbakk.net> <3DB6CF9E.327E165F@us.ibm.com> 
	<200210241214.59812.roy@karlsbakk.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 24 Oct 2002 03:46:53 -0700
Message-Id: <1035456413.10558.5.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-24 at 03:14, Roy Sigurd Karlsbakk wrote:
> I can't use sendfile(). I'm working with files > 4GB, and from man 2 sendfile:

That's what sendfile64() is for.  In fact every vendor I am aware
of is shipping the sys_sendfile64() patch in their kernels and
an appropriately fixed up glibc.

