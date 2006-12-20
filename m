Return-Path: <linux-kernel-owner+w=401wt.eu-S932964AbWLTCIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932964AbWLTCIF (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 21:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932968AbWLTCIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 21:08:05 -0500
Received: from smtp.osdl.org ([65.172.181.25]:54107 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932960AbWLTCID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 21:08:03 -0500
Date: Tue, 19 Dec 2006 18:03:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Suzuki <suzuki@in.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org,
       cmm@us.ibm.com, amit <amitarora@in.ibm.com>, jack@suse.cz
Subject: Re: [RFC] [PATCH] Fix kmalloc flags used in ext3 with an active
 journal handle
Message-Id: <20061219180358.bfda00f0.akpm@osdl.org>
In-Reply-To: <458898B4.5010805@in.ibm.com>
References: <458898B4.5010805@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2006 17:58:12 -0800
Suzuki <suzuki@in.ibm.com> wrote:

> * Fix the kmalloc flags used from within ext3, when we have an active journal handle
> 
> 	If we do a kmalloc with GFP_KERNEL on system running low on memory, with an active journal handle, we might end up in cleaning up the fs cache flushing dirty inodes for some other filesystem. This would cause hitting a J_ASSERT() in :

The change might be needed (haven't looked at it yet).  But I'd like to see
the full BUG trace, please.  To see the callchain.

Always include the trace...

Thanks.
