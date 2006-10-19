Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946575AbWJSWUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946575AbWJSWUF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 18:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946584AbWJSWUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 18:20:05 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42730 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946575AbWJSWUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 18:20:03 -0400
Subject: Re: [im]proper use of stack?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: mfbaustx <mfbaustx@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <op.thofmaaanwjy9v@titan.bintz-dev.net>
References: <op.thofmaaanwjy9v@titan.bintz-dev.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Oct 2006 23:22:43 +0100
Message-Id: <1161296563.17335.153.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-19 am 11:23 -0500, ysgrifennodd mfbaustx:
> So... I know that there is some small-ish amount of kernel stack space  
> available per-process, and the kernel uses this area when executing on a  
> process's behalf (system call, etc).  Let's say I allocate (via an  
> automatic/stack-based storage) some smallish structure which I want a  
> kernel thread to populate (or interrupt context... some context other than  
> my process's context).
> 
> If my process gets context swapped, is my kernel-based stack pointer  
> always valid?

Have a look how the kernel sleep/wakeup system work. We rely on the
property that the kernel stacks of tasks don't move nor do they get
swapped out.

