Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbVAEIBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbVAEIBn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 03:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbVAEIBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 03:01:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:6629 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262293AbVAEIBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 03:01:40 -0500
Date: Wed, 5 Jan 2005 00:01:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] request_irq: avoid slash in proc directory entries
Message-Id: <20050105000129.63478670.akpm@osdl.org>
In-Reply-To: <20050105075357.GA12473@suse.de>
References: <20050105075357.GA12473@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering <olh@suse.de> wrote:
>
> A few users of request_irq pass a string with '/'.
>  As a result, ls -l /proc/irq/*/* will fail to list these entries.

hrm, interesting.  So how do these entries appear in /proc?  Do they
actually have slashes in them?

I get the feeling that something somewhere should be detecting this and
should be propagating an error back.
