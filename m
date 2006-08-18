Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWHRXHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWHRXHs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 19:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWHRXHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 19:07:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45542 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750990AbWHRXHr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 19:07:47 -0400
Date: Fri, 18 Aug 2006 16:07:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix docs for fs.suid_dumpable (#6145)
Message-Id: <20060818160744.50dec49c.akpm@osdl.org>
In-Reply-To: <20060817222652.GE5205@martell.zuzino.mipt.ru>
References: <20060817222652.GE5205@martell.zuzino.mipt.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2006 02:26:52 +0400
Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Sergey Vlasov noticed that there is not kernel.suid_dumpable,
> but fs.suid_dumpable.

Ho hum.

> How KERN_SETUID_DUMPABLE ended up in fs_table[]? Hell knows...

The tables in kernel/sys.c are a common source of patch conflicts. 
patch(1) likes to solve this problem by putting new additions into the
wrong array.

