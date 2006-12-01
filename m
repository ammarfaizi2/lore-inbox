Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759080AbWLAFXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759080AbWLAFXH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 00:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759083AbWLAFXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 00:23:06 -0500
Received: from smtp.osdl.org ([65.172.181.25]:37779 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1759080AbWLAFXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 00:23:03 -0500
Date: Thu, 30 Nov 2006 21:22:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Igmar Palsenberg <i.palsenberg@jdi-ict.nl>
Cc: linux-kernel@vger.kernel.org, erich@areca.com.tw
Subject: Re: 2.6.16.32 stuck in generic_file_aio_write()
Message-Id: <20061130212248.1b49bd32.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0611291329060.18799@jdi.jdi-ict.nl>
References: <Pine.LNX.4.58.0611291329060.18799@jdi.jdi-ict.nl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 13:41:37 +0100 (CET)
Igmar Palsenberg <i.palsenberg@jdi-ict.nl> wrote:

> I've got a machine which occasionally locks up. I can still sysrq it from 
> a serial console, so it's not entirely dead.
> 
> A sysrq-t learns me that it's got a large number of httpd processes stuck 
> in D state :

There are known deadlocks in generic_file_write() in kernels up to and
including 2.6.17.  Pagefaults are involved and I'd need to see the entire
sysrq-T output to determine if you're hitting that bug.


