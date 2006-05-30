Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWE3Uxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWE3Uxa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 16:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbWE3Ux3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 16:53:29 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:11519 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932417AbWE3Ux3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 16:53:29 -0400
Subject: Re: [patch 38/61] lock validator: special locking: i_mutex
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060529212613.GL3155@elte.hu>
References: <20060529212613.GL3155@elte.hu>
Content-Type: text/plain
Date: Tue, 30 May 2006 16:53:21 -0400
Message-Id: <1149022401.21827.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-29 at 23:26 +0200, Ingo Molnar wrote:
> + * inode->i_mutex nesting types for the LOCKDEP validator:
> + *
> + * 0: the object of the current VFS operation
> + * 1: parent
> + * 2: child/target
> + */
> +enum inode_i_mutex_lock_type
> +{
> +       I_MUTEX_NORMAL,
> +       I_MUTEX_PARENT,
> +       I_MUTEX_CHILD
> +};
> +
> +/* 

I guess we can say the same about I_MUTEX_NORMAL.

-- Steve


