Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbSJONxl>; Tue, 15 Oct 2002 09:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262825AbSJONxl>; Tue, 15 Oct 2002 09:53:41 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:48127 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262821AbSJONxk>; Tue, 15 Oct 2002 09:53:40 -0400
Date: Tue, 15 Oct 2002 07:00:29 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Oleg Drokin <green@namesys.com>
Cc: Jeff Dike <jdike@karaya.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: uml-patch-2.5.42-1
Message-ID: <20021015140029.GA1378@beaverton.ibm.com>
Mail-Followup-To: Oleg Drokin <green@namesys.com>,
	Jeff Dike <jdike@karaya.com>,
	user-mode-linux-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20021015104210.A1335@namesys.com> <200210151352.IAA02057@ccure.karaya.com> <20021015170558.A6060@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015170558.A6060@namesys.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin [green@namesys.com] wrote:
> Hello!
> 
> On Tue, Oct 15, 2002 at 08:52:17AM -0500, Jeff Dike wrote:
> 
> > > For some reason I now need this patch to make bk-current to compile 
> > That patch is against stock 2.5.42, so I don't make any guarantees about
> > bk-current.

I was seeing the same failure on 2.5.42.

> 
> I am in no way inplying that you are making any guarantees about your patches to
> work with something but the kernels they are released for.
> On the other hand I thought you might find it useful if I report to you
> problems with more modern kernels that I encounter so that when you will
> update UML to never kernel you do not need to hit all the problems by yourself.
> 
> > However the __i386__ thing should be taken care of by Makefile-i386 doing
> > 	CFLAGS += -U__i386__
> > I might have messed up the patch, I'll check and fix it if so.
> 
> Yes, it seems to be the case.
> 
> CFLAGS is defined first in arch/um/Makefile and only then you do
> include Makefile-{SUBARCH}
> 
> Moving 'include $(ARCH_DIR)/Makefile-$(SUBARCH)' in front of CFLAGS
> helped.

This fixed the __i386__ issue, but messed up the header symlinks. I
moved CFLAGS after the includes and this appears to have fixed both
problems, but makefile magic is not my thing so YMMV.

-andmike
--
Michael Anderson
andmike@us.ibm.com

