Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbVBAJJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVBAJJk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 04:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVBAJJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 04:09:39 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35816 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261948AbVBAJIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 04:08:47 -0500
To: Koichi Suzuki <koichi@intellilink.co.jp>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Maneesh Soni <maneesh@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based	crashdumps.
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	<1106294155.26219.26.camel@2fwv946.in.ibm.com>
	<m1sm4v2p5t.fsf@ebiederm.dsl.xmission.com>
	<1106305073.26219.46.camel@2fwv946.in.ibm.com>
	<m17jm72fy1.fsf@ebiederm.dsl.xmission.com>
	<1106475280.26219.125.camel@2fwv946.in.ibm.com>
	<m18y6gf6mj.fsf@ebiederm.dsl.xmission.com>
	<1106833527.15652.146.camel@2fwv946.in.ibm.com>
	<m1zmyueh4c.fsf@ebiederm.dsl.xmission.com>
	<41FF381B.4080904@intellilink.co.jp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 Feb 2005 02:06:42 -0700
In-Reply-To: <41FF381B.4080904@intellilink.co.jp>
Message-ID: <m1fz0gbqe5.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Koichi Suzuki <koichi@intellilink.co.jp> writes:

> Hook in panic code is very good idea and is useful in various scenes. It could
> be used to kick RAM dump code, obviously, and also kick the code to initiate
> failover, etc.   Various use could be possible so I believe that this hook
> should be prepared for wider use.

It is.  Basically it is the normal kexec interface that allows you to
boot another kernel.  With a few restrictions that should keep it as
reliable as possible when the kernel has not shut itself down cleanly.

The hardest case is to do a useful system core dump.  As that requires
looking at what has gone before.  For the rest if you can do it
with a kernel and a initramfs you are in good shape.

There seems to be a significant amount of interest in the full
system core dump case so that is what the work is concentrating
on.

Eric
