Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbUKILHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbUKILHL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 06:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbUKILHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 06:07:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:29874 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261502AbUKILEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 06:04:12 -0500
Date: Tue, 9 Nov 2004 03:04:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg Banks <gnb@melbourne.sgi.com>
Cc: oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/11] oprofile: add check_user_page_readable()
Message-Id: <20041109030403.7a306fcd.akpm@osdl.org>
In-Reply-To: <1099996636.1985.781.camel@hole.melbourne.sgi.com>
References: <1099996636.1985.781.camel@hole.melbourne.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Banks <gnb@melbourne.sgi.com> wrote:
>
> Add check_user_page_readable() for kernel modules which need
>  to follow user space addresses but can't use get_user().

Strange.  What is the usage pattern for this?  And why is that usage
pattern not racy in the presence of paging activity?

Did you consider use_mm(), in conjunction with get_user()?
