Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbVKCCqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbVKCCqA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 21:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbVKCCp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 21:45:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41345 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030269AbVKCCp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 21:45:59 -0500
Date: Thu, 3 Nov 2005 12:45:36 +1100
From: Andrew Morton <akpm@osdl.org>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, mark.fasheh@oracle.com
Subject: Re: [Patch] add AOP_TRUNCATED_PAGE, prepend AOP_ to
 WRITEPAGE_ACTIVATE
Message-Id: <20051103124536.0191bea6.akpm@osdl.org>
In-Reply-To: <43667913.4030401@oracle.com>
References: <43667913.4030401@oracle.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown <zach.brown@oracle.com> wrote:
>
> readpage(), prepare_write(), and commit_write() callers are updated to
>  understand the special return code AOP_TRUNCATED_PAGE in the style of
>  writepage() and WRITEPAGE_ACTIVATE.  AOP_TRUNCATED_PAGE tells the caller that
>  the callee has unlocked the page and that the operation should be tried again
>  with a new page.  OCFS2 uses this to detect and work around a lock inversion in
>  its aop methods.  There should be no change in behaviour for methods that don't
>  return AOP_TRUNCATED_PAGE.
> 
>  WRITEPAGE_ACTIVATE is also prepended with AOP_ for consistency and they are
>  made enums so that kerneldoc can be used to document their semantics.

Looks sane to me.   Can you carry this in the ocfs2 tree?
