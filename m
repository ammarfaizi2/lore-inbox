Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262875AbUJ1Gty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262875AbUJ1Gty (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 02:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262876AbUJ1Gog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 02:44:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:51347 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262870AbUJ1Gnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 02:43:32 -0400
Date: Wed, 27 Oct 2004 23:41:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com
Subject: Re: [PATCH] Make key management syscalls work on PPC/PPC64
Message-Id: <20041027234109.19b39e93.akpm@osdl.org>
In-Reply-To: <24857.1098904121@redhat.com>
References: <24857.1098904121@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> The attached patch permits my key management stuff to be used on PPC, PPC64
>  and PPC on PPC64.

Please remember to test your patches with CONFIG_KEYS=n

--- 25-power4/kernel/sys.c~ppc-ppc64-make-key-management-syscalls-work-fix	2004-10-27 23:26:16.330512080 -0700
+++ 25-power4-akpm/kernel/sys.c	2004-10-27 23:27:04.516186744 -0700
@@ -286,6 +286,7 @@ cond_syscall(compat_set_mempolicy)
 cond_syscall(sys_add_key)
 cond_syscall(sys_request_key)
 cond_syscall(sys_keyctl)
+cond_syscall(compat_keyctl)
 cond_syscall(compat_sys_socketcall)
 
 /* arch-specific weak syscall entries */
_

