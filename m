Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVCILF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVCILF7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 06:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVCILF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 06:05:59 -0500
Received: from fire.osdl.org ([65.172.181.4]:64411 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261564AbVCILFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 06:05:55 -0500
Date: Wed, 9 Mar 2005 03:05:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: suparna@in.ibm.com
Cc: dhowells@redhat.com, pbadari@us.ibm.com, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: aio stress panic on 2.6.11-mm1
Message-Id: <20050309030512.1e1921b6.akpm@osdl.org>
In-Reply-To: <20050309110404.GA4088@in.ibm.com>
References: <20050308170107.231a145c.akpm@osdl.org>
	<1110327267.24286.139.camel@dyn318077bld.beaverton.ibm.com>
	<18744.1110364438@redhat.com>
	<20050309110404.GA4088@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> wrote:
>
> Any sense of how costly it is to use spin_lock_irq's vs spin_lock
>  (across different architectures) ? Isn't rwsem used very widely ?

It's only on the slow path, and we've already done a bunch of atomic ops
and a schedule()/wakeup() anyway.
