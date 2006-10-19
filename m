Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751593AbWJSNHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbWJSNHn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 09:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbWJSNHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 09:07:43 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:22471 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751523AbWJSNHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 09:07:42 -0400
Subject: Re: [PATCH] tty: ->signal->tty locking
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Oleg Nesterov <oleg@tv-sign.ru>, Prarit Bhargava <prarit@redhat.com>,
       Chris Wright <chrisw@sous-sol.org>
In-Reply-To: <1161260013.3036.92.camel@taijtu>
References: <1161260013.3036.92.camel@taijtu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Oct 2006 14:09:55 +0100
Message-Id: <1161263396.17335.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-19 am 14:13 +0200, ysgrifennodd Peter Zijlstra:
> Fix the locking of signal->tty.
> 
> Use ->sighand->siglock to protect ->signal->tty; this lock is already used
> by most other members of ->signal/->sighand. And unless we are 'current' or
> the tasklist_lock is held we need ->siglock to access ->signal anyway.


Nice

Acked-by: Alan Cox <alan@redhat.com>

