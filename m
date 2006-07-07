Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWGGHVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWGGHVL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 03:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWGGHVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 03:21:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15821 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750778AbWGGHVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 03:21:09 -0400
Subject: Re: Strange Linux behaviour with blocking syscalls and stop
	signals+SIGCONT
From: Arjan van de Ven <arjan@infradead.org>
To: Michael Kerrisk <michael.kerrisk@gmx.net>
Cc: Ulrich Drepper <drepper@redhat.com>, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org, tytso@mit.edu, torvalds@osdl.org,
       eggert@cs.ucla.edu, roland@redhat.com, rlove@rlove.org,
       mtk-lkml@gmx.net, mtk-manpages@gmx.net
In-Reply-To: <20060707070334.186790@gmx.net>
References: <44A92DC8.9000401@gmx.net> <44AABB31.8060605@colorfullife.com>
	 <20060706092328.320300@gmx.net> <44AD599D.70803@colorfullife.com>
	 <44AD5CB6.7000607@redhat.com> <20060707043220.186800@gmx.net>
	 <44ADE9B6.1020900@redhat.com> <20060707050731.186770@gmx.net>
	 <44ADFD43.4040204@redhat.com>  <20060707070334.186790@gmx.net>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 09:20:56 +0200
Message-Id: <1152256856.3111.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> There must be some framework for changing the kernel ABI over time.
> We can't remain forever stuck with an ABI behaviour because 
> of the development model (i.e., no 2.7/2.8). 

Hi,

this has nothing to do with the development model. The userspace syscall
ABI *has* to be stable. If we make a mistake that's a high price but we
pay it. This fwiw is one of the reasons we are/should be very careful
with adding system calls, and make sure the behavior is indeed right.
It's also the reason we're not so happy about new ioctls; they're
effectively mini-system calls with the same ABI issues, but just less
controlled/reviewed/designed/visible.

Greetings,
  Arjan van de Ven

