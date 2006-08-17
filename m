Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWHQNoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWHQNoq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWHQNop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:44:45 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:22146 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964988AbWHQNoj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:44:39 -0400
Message-ID: <44E47354.1020902@sw.ru>
Date: Thu, 17 Aug 2006 17:47:00 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 5/7] UBC: kernel memory accounting (core)
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru> <1155747362.24077.378.camel@localhost.localdomain>
In-Reply-To: <1155747362.24077.378.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The 
> 
> +       ub->ub_parms[UB_KMEMSIZE].limit = 32 * 1024 * 1024
> 
> seems a bit arbitary. 32Mb is variously vast amounts of memory and not
> enough to boot depending if you are booting a PDA or a 4096 core Itanic
> box
this limit is for newly created UBs, host system (ub0) is
_unlimited_ by default.
The idea was to limit the user by default to make system secure.
do you think it is good idea to have unlimited users created by default?
Anyway, after creating UB context normal behaviour would be to set
some limits.

Thanks,
Kirill

