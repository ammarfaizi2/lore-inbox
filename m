Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032073AbWLGLrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032073AbWLGLrI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 06:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032077AbWLGLrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 06:47:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39649 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032073AbWLGLrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 06:47:07 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061207032817.e9e587bd.akpm@osdl.org> 
References: <20061207032817.e9e587bd.akpm@osdl.org>  <20061207.000950.28414823.davem@davemloft.net> <10380.1165489429@redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, David Miller <davem@davemloft.net>,
       viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: cmpxchg() in kernel/workqueue.c breaks things 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 07 Dec 2006 11:46:24 +0000
Message-ID: <23292.1165491984@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> I don't see why the 2.6.19 logic needed changing.
> 
> a) Nobody should be freeing the work_struct itself without running
>    flush_scheduled_work() and
> 
> b) even if the work_struct _did_ get freed, the callback function won't
>    care, because there's nothing in that work_struct which it's interested
>    in.

Erm...  Did you mean that in reply to my suggestion that we don't need to use
cmpxchg()?

We might want to avoid cmpxchg() because it isn't available on all platforms
under all circumstances, and besides I'm not sure it's actually necessary.

David
