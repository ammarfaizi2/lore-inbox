Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267402AbUGVXcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267402AbUGVXcb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 19:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267377AbUGVXaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 19:30:05 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:57283 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S267375AbUGVX3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 19:29:48 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Joel n.solanki" <zealous@bonbon.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: unresloved systems /drm/sis.o 
In-reply-to: Your message of "22 Jul 2004 13:54:41 +0530."
             <1090484680.2312.5.camel@joel.d2visp.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 23 Jul 2004 09:29:41 +1000
Message-ID: <28336.1090538981@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jul 2004 13:54:41 +0530, 
"Joel n.solanki" <zealous@bonbon.net> wrote:
>I have compiled 2.4.21 kernel downloaded from kernel.org
>all things went good according to my choice.
>But when doing make modules_install i got the error for Unresolved
>sysmbols.
>
>Result of depmod -a
>
>
>[root@joel root]# depmod -a
>depmod: *** Unresolved symbols in
>/lib/modules/2.4.21/kernel/drivers/char/drm/sis.o

You need CONFIG_FB_SIS=y to go with CONFIG_DRM_SIS=y.  The 2.4 build
system cannot detect the requirement, you have to set CONFIG_FB_SIS=y
by hand.

