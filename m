Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266738AbUGLFIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266738AbUGLFIv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 01:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266736AbUGLFIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 01:08:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:25057 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266738AbUGLFI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 01:08:27 -0400
Date: Sun, 11 Jul 2004 22:07:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Shai Fultheim" <shai@scalex86.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Alignment for CPU maps, add padding semantics
Message-Id: <20040711220715.516cd475.akpm@osdl.org>
In-Reply-To: <200407112253.i6BMrEws001373@fire-2.osdl.org>
References: <200407112253.i6BMrEws001373@fire-2.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Shai Fultheim" <shai@scalex86.org> wrote:
>
> +#define ____cacheline_pad_in_smp struct { char  x; } ____cacheline_maxaligned_in_smp

anonymous structs don't work with gcc-2.95.  The build emits nine
gazillion of these:

include/linux/mmzone.h:135: warning: unnamed struct/union that defines no instances
include/linux/mmzone.h:147: warning: unnamed struct/union that defines no instances
include/linux/mmzone.h:201: warning: unnamed struct/union that defines no instances

