Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262810AbSJONAL>; Tue, 15 Oct 2002 09:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbSJONAK>; Tue, 15 Oct 2002 09:00:10 -0400
Received: from angband.namesys.com ([212.16.7.85]:13184 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S262810AbSJONAJ>; Tue, 15 Oct 2002 09:00:09 -0400
Date: Tue, 15 Oct 2002 17:05:58 +0400
From: Oleg Drokin <green@namesys.com>
To: Jeff Dike <jdike@karaya.com>
Cc: Mike Anderson <andmike@us.ibm.com>,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: uml-patch-2.5.42-1
Message-ID: <20021015170558.A6060@namesys.com>
References: <20021015104210.A1335@namesys.com> <200210151352.IAA02057@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200210151352.IAA02057@ccure.karaya.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Oct 15, 2002 at 08:52:17AM -0500, Jeff Dike wrote:

> > For some reason I now need this patch to make bk-current to compile 
> That patch is against stock 2.5.42, so I don't make any guarantees about
> bk-current.

I am in no way inplying that you are making any guarantees about your patches to
work with something but the kernels they are released for.
On the other hand I thought you might find it useful if I report to you
problems with more modern kernels that I encounter so that when you will
update UML to never kernel you do not need to hit all the problems by yourself.

> However the __i386__ thing should be taken care of by Makefile-i386 doing
> 	CFLAGS += -U__i386__
> I might have messed up the patch, I'll check and fix it if so.

Yes, it seems to be the case.

CFLAGS is defined first in arch/um/Makefile and only then you do
include Makefile-{SUBARCH}

Moving 'include $(ARCH_DIR)/Makefile-$(SUBARCH)' in front of CFLAGS
helped.

Bye,
    Oleg
