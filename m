Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263895AbUDVJ5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbUDVJ5C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 05:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263901AbUDVJ5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 05:57:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:58791 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263895AbUDVJ47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 05:56:59 -0400
Date: Thu, 22 Apr 2004 02:56:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Waechtler <pwaechtler@mac.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] coredump - as root not only if euid switched
Message-Id: <20040422025638.0bf86599.akpm@osdl.org>
In-Reply-To: <2899705.1082626850875.JavaMail.pwaechtler@mac.com>
References: <2899705.1082626850875.JavaMail.pwaechtler@mac.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Waechtler <pwaechtler@mac.com> wrote:
>
>  >(why are you trying to unlink the old file anyway?)
>  >
> 
>  For security measure :O
>  I tried on solaris: touch the core file as user, open it and wait, dump core
>  as root -> nope, couldn't read the damn core - it was unlinked and created!

hm, OK.  There's a window in which someone can come in and recreate the
file, but the open is using O_EXCL|O_CREATE so that seems safe enough.

