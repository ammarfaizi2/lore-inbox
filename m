Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266891AbUJBAox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266891AbUJBAox (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 20:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266910AbUJBAox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 20:44:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:11654 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266891AbUJBAow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 20:44:52 -0400
Date: Fri, 1 Oct 2004 17:42:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm4 ps hang ?
Message-Id: <20041001174238.2efec4ef.akpm@osdl.org>
In-Reply-To: <1096676949.12861.96.camel@dyn318077bld.beaverton.ibm.com>
References: <1096646925.12861.50.camel@dyn318077bld.beaverton.ibm.com>
	<20041001120926.4d6f58d5.akpm@osdl.org>
	<1096666140.12861.82.camel@dyn318077bld.beaverton.ibm.com>
	<20041001145536.182dada9.akpm@osdl.org>
	<1096672002.12861.84.camel@dyn318077bld.beaverton.ibm.com>
	<20041001164938.3231482e.akpm@osdl.org>
	<1096676949.12861.96.camel@dyn318077bld.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> Why would I be stuck in spin_unlock() ?

Maybe that's where the CPU happened to be when the interrupt came in.
That'll happen if it's looping tightly.  Try generating more sysrq
traces?
