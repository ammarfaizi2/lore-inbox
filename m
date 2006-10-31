Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423865AbWJaXqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423865AbWJaXqH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 18:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423866AbWJaXqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 18:46:06 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48042 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1423867AbWJaXqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 18:46:04 -0500
Subject: Re: [patch 1/1] schedule removal of FUTEX_FD
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, mingo@elte.hu,
       rusty@rustcorp.com.au, tglx@linutronix.de
In-Reply-To: <200610312309.k9VN9mco015260@shell0.pdx.osdl.net>
References: <200610312309.k9VN9mco015260@shell0.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 31 Oct 2006 23:48:11 +0000
Message-Id: <1162338491.11965.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-10-31 am 15:09 -0800, ysgrifennodd akpm@osdl.org:
> From: Andrew Morton <akpm@osdl.org>
> 
> Apparently FUTEX_FD is unfixably racy and nothing uses it (or if it does, it
> shouldn't).
> 
> Add a warning printk, give any remaining users six months to migrate off it.

Andrew - please use time based rate limits for this sort of thing, that
way you actually get to see who is actually using it. Probably doesn't
matter for the FUTEX_FD case as nobody does, but in general the 'ten
times during boot' approach is not as good as ratelimit(): Perhaps
net_ratelimit() ought to become more general ?

