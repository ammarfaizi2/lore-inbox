Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVFLWvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVFLWvM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 18:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVFLWvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 18:51:12 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:37076 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261265AbVFLWvK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 18:51:10 -0400
Subject: Re: Add pselect, ppoll system calls.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       torvalds@osdl.org, drepper@redhat.com
In-Reply-To: <1118444314.4823.81.camel@localhost.localdomain>
References: <1118444314.4823.81.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1118616499.9949.103.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 12 Jun 2005 23:48:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-06-10 at 23:58, David Woodhouse wrote:
> The idea of pselect is that if one wants to wait for an event, either a
> signal  or  something on a file descriptor, an atomic test is needed to
> prevent race conditions. (Suppose the signal handler sets a global flag
> and  returns.  Then  a  test  of this global flag followed by a call of
> select() could hang indefinitely if the signal arrived just  after  the
> test but just before the call. On the other hand, pselect allows one to

See sleep(), going back to oh V7 unix. It has this avoided nicely in
user space using setjmp (nowdays using sigsetjmp).

If glibc has a race why not just fix glibc ?

