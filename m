Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263777AbTCUTOD>; Fri, 21 Mar 2003 14:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263910AbTCUTMj>; Fri, 21 Mar 2003 14:12:39 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:12813
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263902AbTCUTMJ>; Fri, 21 Mar 2003 14:12:09 -0500
Subject: Re: [PATCH] arch-independent syscalls to return long
From: Robert Love <rml@tech9.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: akpm@digeo.com, Linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       ak@suse.de
In-Reply-To: <20030321104649.5d8f5c62.rddunlap@osdl.org>
References: <3E7AAD0C.B8CB2926@verizon.net>
	 <20030320222358.454a1f4f.akpm@digeo.com>
	 <1048229509.2026.19.camel@phantasy.awol.org>
	 <20030321104649.5d8f5c62.rddunlap@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1048274593.4908.26.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 21 Mar 2003 14:23:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-21 at 13:46, Randy.Dunlap wrote:

> On 21 Mar 2003 01:51:50 -0500 Robert Love <rml@tech9.net> wrote:
> 
> | -extern asmlinkage int sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
> | +extern long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
> 
> keep the asmlinkage (or why not?)

I always that it did not matter, but Arjan just pointed out otherwise
(as you saw).  So I guess these need to be reverted.

There are a handful of other such cases around the kernel...

	Robert Love

