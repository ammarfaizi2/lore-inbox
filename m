Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268737AbUIQMiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268737AbUIQMiu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 08:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268734AbUIQMiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 08:38:50 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:51885 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S268728AbUIQMiB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 08:38:01 -0400
From: Duncan Sands <baldrick@free.fr>
To: Stelian Pop <stelian@popies.net>
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Date: Fri, 17 Sep 2004 14:37:57 +0200
User-Agent: KMail/1.6.2
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20040917102413.GA3089@crusoe.alcove-fr> <Pine.LNX.4.44.0409171228240.4678-100000@localhost.localdomain> <20040917122400.GD3089@crusoe.alcove-fr>
In-Reply-To: <20040917122400.GD3089@crusoe.alcove-fr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409171437.57766.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> + * Note that with only one concurrent reader and one concurrent 
> + * writer, you don't need extra locking to use these functions.
                                 ^^^^^ which functions? (ambiguous)
And what does "extra locking" mean?

> +	len = min(len, fifo->size - fifo->in + fifo->out);

After all, since you are reading both in and out here, some kind of
locking is needed.

Ciao,

Duncan.
