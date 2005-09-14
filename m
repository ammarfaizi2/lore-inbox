Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbVINWlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbVINWlO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965080AbVINWlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:41:14 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:21888 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S965077AbVINWlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:41:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.14-rc1 on ATI hangs when executing _STA and _INI methods
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
	<m3y85z8flv.fsf@telia.com>
	<Pine.LNX.4.58.0509141521370.26803@g5.osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 15 Sep 2005 00:41:00 +0200
In-Reply-To: <Pine.LNX.4.58.0509141521370.26803@g5.osdl.org>
Message-ID: <m3r7br8e83.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 15 Sep 2005, Peter Osterlund wrote:
> > 
> > My Compaq Presario R3057EA hangs during ACPI initialization. The last
> > message is "Executing all Device _STA and _INI methods". git bisect
> > told me that:
> > 
> >   66759a01adbfe8828dd063e32cf5ed3f46696181 is first bad commit
> >   diff-tree 66759a01adbfe8828dd063e32cf5ed3f46696181 (from 049cdefe19f95b67b06b70915cd8e4ae7173337a)
> >   Author: Chuck Ebbert <76306.1226@compuserve.com>
> >   Date:   Mon Sep 12 18:49:25 2005 +0200
> > 
> >     [PATCH] x86-64: i386/x86-64: Fix time going twice as fast problem on ATI Xpress chipsets
> > 
> > Passing enable_timer_pin_1 as a kernel boot parameter doesn't help,
> > but this patch does:
> 
> Ok. That patch has been one big pain, and was clearly totally half-baked.  
> I think I'll disable the automated checks, since they are clearly wrong.
> You can still enable it manually with a kernel command line.
> 
> So something like this.. I assume this works for you?

Yes it does.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
