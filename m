Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263642AbTKKRvj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 12:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbTKKRvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 12:51:39 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:15372
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263642AbTKKRvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 12:51:36 -0500
Subject: Re: 2.6 /proc/interrupts fails on systems with many CPUs
From: Robert Love <rml@tech9.net>
To: Erik Jacobson <erikj@subway.americas.sgi.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SGI.4.53.0311111116440.360387@subway.americas.sgi.com>
References: <Pine.SGI.4.53.0311111116440.360387@subway.americas.sgi.com>
Content-Type: text/plain
Message-Id: <1068573095.13760.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 11 Nov 2003 12:51:36 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-11-11 at 12:21, Erik Jacobson wrote:

> static int interrupts_open(struct inode *inode, struct file *file)
> {
>    unsigned size = 4096 * (1 + num_online_cpus() / 8);
>    char *buf = kmalloc(size, GFP_KERNEL);
> 
> The kmalloc fails here.

Ew.

We should probably use seq_file here, although vmalloc() should not
hurt.

Why __vmalloc() over vmalloc(), though?  Eh, I do not even know what
__vmalloc() is?? ;)

	Robert Love


