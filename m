Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbUKUVK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbUKUVK6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 16:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbUKUVK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 16:10:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:5794 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261806AbUKUVKz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 16:10:55 -0500
Date: Sun, 21 Nov 2004 13:10:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: ptb@inv.it.uc3m.es
Cc: ptb@it.uc3m.es, linux-kernel@vger.kernel.org
Subject: Re: can kfree sleep?
Message-Id: <20041121131038.6c55b91c.akpm@osdl.org>
In-Reply-To: <200411211223.iALCNCTL005995@betty.it.uc3m.es>
References: <200411211223.iALCNCTL005995@betty.it.uc3m.es>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter T. Breuer" <ptb@it.uc3m.es> wrote:
>
> Just a question: can kfree sleep?

Nope.  All memory freeing codepaths are atomic and may be called from any
context except NMI handlers.
