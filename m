Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965107AbWHQO6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbWHQO6D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbWHQO6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:58:01 -0400
Received: from mail.suse.de ([195.135.220.2]:48285 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932110AbWHQO57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:57:59 -0400
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting (core)
Date: Thu, 17 Aug 2006 18:04:40 +0200
User-Agent: KMail/1.9.1
Cc: Dave Hansen <haveblue@us.ibm.com>, rohitseth@google.com,
       Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@sw.ru>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Pavel Emelianov <xemul@openvz.org>
References: <44E33893.6020700@sw.ru> <1155824788.9274.32.camel@localhost.localdomain> <1155826917.15195.101.camel@localhost.localdomain>
In-Reply-To: <1155826917.15195.101.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608171804.41433.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I don't see any good way around that. For the page struct it is a
> material issue, for the others its not a big deal providing we avoid
> accounting dumb stuff like dentries.
>
> At the VM summit Linus suggested one option for user page allocation
> tracking would be to track not per page but by block of pages (say the
> 2MB chunks) and hand those out per container. That would really need the
> defrag work though.

One could always use a second set of arrays, mirroring mem_map

-Andi
