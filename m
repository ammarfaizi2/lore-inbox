Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268089AbTGIJ7q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 05:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268065AbTGIJ7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 05:59:34 -0400
Received: from air-2.osdl.org ([65.172.181.6]:35540 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265904AbTGIJ5V (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 05:57:21 -0400
Date: Wed, 9 Jul 2003 03:12:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Linux-Kernel@vger.kernel.org
Subject: Re: [PATCH] 3/5 VM changes: dont-rotate-active-list.patch
Message-Id: <20030709031217.21b54196.akpm@osdl.org>
In-Reply-To: <16139.54928.435252.933882@laputa.namesys.com>
References: <16139.54928.435252.933882@laputa.namesys.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov <Nikita@Namesys.COM> wrote:
>
> This patch modifies refill_inactive_zone() so that it scans active_list
>  without rotating it. 

I'm unconvinced.  The scanning of the active list allows us to keep the
referenced state uptodate and balanced across all pages.

