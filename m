Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbVCJNFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbVCJNFg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 08:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbVCJNDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 08:03:49 -0500
Received: from fire.osdl.org ([65.172.181.4]:36763 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262592AbVCJNCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 08:02:53 -0500
Date: Thu, 10 Mar 2005 05:02:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, trond.myklebust@fys.uio.no,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: Discard key spinlock and use RCU for key payload
 [try #3]
Message-Id: <20050310050209.1d95a5dc.akpm@osdl.org>
In-Reply-To: <5005.1110459008@redhat.com>
References: <20050310042217.3ba5b9bc.akpm@osdl.org>
	<4181.1110456111@redhat.com>
	<5005.1110459008@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > What's with the preempt_enable()/disable() added to __key_link()?  It's not
> > obvious what is being protected from what, and why.
> 
> Ummm... Yes... They're probably not necessary. A wmb() may be required after
> the klist->nkeys++ to commit to memory the fact there's now an extra key link
> available, but I'm not sure that it's necessary.

ok...

> Do you want me to redo the patch?
> 

That, or a delta.  At your convenience.

What's your feeling on the stability&&priority of this work?
