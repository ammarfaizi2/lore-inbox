Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263264AbTJBJPx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 05:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263317AbTJBJPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 05:15:53 -0400
Received: from pizda.ninka.net ([216.101.162.242]:40852 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263264AbTJBJPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 05:15:52 -0400
Date: Thu, 2 Oct 2003 02:10:37 -0700
From: "David S. Miller" <davem@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@osdl.org, zaitcev@redhat.com, braam@clusterfs.com,
       thockin@hockin.org, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com, davidm@hpl.hp.com
Subject: Re: [PATCH] Many groups patch.
Message-Id: <20031002021037.3e6706c4.davem@redhat.com>
In-Reply-To: <20031002022545.6FB7A2C0EA@lists.samba.org>
References: <Pine.LNX.4.44.0310011216530.24564-100000@home.osdl.org>
	<20031002022545.6FB7A2C0EA@lists.samba.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Oct 2003 12:09:19 +1000
Rusty Russell <rusty@rustcorp.com.au> wrote:

> Sure.  First step is to put this function in kernel/compat.c where it
> belongs.  The identical function is already in kernel/uid16.c, but
> defining CONFIG_UID16 does not work for these platforms (which only
> want 16-bit uids for the 32-bit syscalls).

This is correct.  To be more precise, we also need it for the compat
ABI binary format handlers too (elf32, etc.)
