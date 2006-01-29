Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWA2Id5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWA2Id5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 03:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWA2Id5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 03:33:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22503 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750740AbWA2Id4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 03:33:56 -0500
Date: Sun, 29 Jan 2006 00:33:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pid: Don't hash pid 0.
Message-Id: <20060129003338.28675b78.akpm@osdl.org>
In-Reply-To: <m1ek2rfsu9.fsf@ebiederm.dsl.xmission.com>
References: <m1ek2rfsu9.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> pid 0 is never exported to userspace, so hashing it servers no useful
>  purpose.

uh-huh.

>  Explicitly not hashing pid 0 allows struct pid to be marked as not
>  hashed, and it allows us to avoid checks if for pid 0 when searching
>  for processes to signal if pid 0 does not have a special meaning.

Were you planning on sending a patch to avoid those checks?  Because right
now, this patch looks like a net loss.
