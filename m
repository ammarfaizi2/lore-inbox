Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWIEQWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWIEQWA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 12:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWIEQWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 12:22:00 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:43923 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932127AbWIEQV6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 12:21:58 -0400
Subject: Re: [ckrm-tech] [PATCH 6/7] BC: kernel memory (core)
From: Dave Hansen <haveblue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Matt Helsley <matthltc@us.ibm.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <44FC1AAF.8040504@sw.ru>
References: <44F45045.70402@sw.ru>  <44F45601.9060807@sw.ru>
	 <1156883382.5408.153.camel@localhost.localdomain>  <44FC1AAF.8040504@sw.ru>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 09:21:34 -0700
Message-Id: <1157473294.3186.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-04 at 16:23 +0400, Kirill Korotaev wrote:
> 
> are you suggesting the code like this:
> >>+#ifdef CONFIG_BEANCOUNTERS
> >>+       union {
> >>+               struct beancounter      *page_bc;
> >>+       };
> >>+#endif
> >> }; 
> 
> #define page_bc(page)   ((page)->page_bc) 

That would be a bit better.  Although, I think the "page_" bit is also
superfluous.

-- Dave

