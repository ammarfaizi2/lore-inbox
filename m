Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbULATmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbULATmt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 14:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbULATmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 14:42:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:65449 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261422AbULATme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 14:42:34 -0500
Date: Wed, 1 Dec 2004 11:41:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: kortyads@mindspring.com, linux-kernel@vger.kernel.org
Subject: Re: waitid breaks telnet
Message-Id: <20041201114141.7f3347a1.akpm@osdl.org>
In-Reply-To: <200412011920.iB1JKlug004542@magilla.sf.frob.com>
References: <20041130202730.6ceab259.akpm@osdl.org>
	<200412011920.iB1JKlug004542@magilla.sf.frob.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> wrote:
>
> I've had no luck reproducing that, so there isn't much I can do.

Did you try bare 2.6.10-rc2?

>  The last
> time someone thought the waitid change broke something random, it was the
> perturbation of the compiled code vs the issue that the kernel's assembly
> code doesn't follow the same calling conventions the compiler expects.

Could be that, but I was able to reproduce it on 2.6.10-rc2 with
gcc-2.95.4, with which -mregparm is disabled.

Still.  It would be interesting if Joe could retest with CONFIG_REGPARM=n?
