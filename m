Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbTGXMWb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 08:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263738AbTGXMWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 08:22:31 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:23300 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S263737AbTGXMW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 08:22:29 -0400
To: cijoml@volny.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: passing my own compiler options into linux kernel compiling
References: <200307240916.17530.cijoml@volny.cz>
	<20030724100111.343d84cd.martin.zwickel@technotrend.de>
	<200307241050.25094.cijoml@volny.cz>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <200307241050.25094.cijoml@volny.cz>
Date: 24 Jul 2003 08:35:29 -0400
Message-ID: <m3isps2jce.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Michal" == Michal Semler <cijoml@volny.cz> writes:

Michal> Is easyer way of passing these args planned? Editing source
Michal> every time I change kernel is not goood way. make oldconfig
Michal> adding these args is better way.

In 2.6 arch/i386/Makefile looks like this;

cflags-$(CONFIG_M686)           += -march=i686
cflags-$(CONFIG_MPENTIUMII)     += $(call check_gcc,-march=pentium2,-march=i686)
cflags-$(CONFIG_MPENTIUMIII)    += $(call check_gcc,-march=pentium3,-march=i686)
cflags-$(CONFIG_MPENTIUM4)      += $(call check_gcc,-march=pentium4,-march=i686)

et al for the other cpu CONFIG options.

IOW it pretty much makes the right choices w/o editing.

-JimC

