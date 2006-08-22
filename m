Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWHVJnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWHVJnW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 05:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWHVJnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 05:43:22 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29921 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751140AbWHVJnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 05:43:21 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH] UBC: user resource beancounters
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: rohitseth@google.com
Cc: sekharan@us.ibm.com, Kirill Korotaev <dev@sw.ru>,
       Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1156211128.11127.37.camel@galaxy.corp.google.com>
References: <44E33893.6020700@sw.ru>
	 <1155929992.26155.60.camel@linuxchandra>  <44E9B3F5.3010000@sw.ru>
	 <1156196721.6479.67.camel@linuxchandra>
	 <1156211128.11127.37.camel@galaxy.corp.google.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Aug 2006 11:02:50 +0100
Message-Id: <1156240970.27114.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-08-21 am 18:45 -0700, ysgrifennodd Rohit Seth:
> I think as the tasks move around, it becomes very heavy to move all the
> pages belonging to previous container to a new container.

Its not a meaningful thing to do. Remember an object may be passed
around or shared. The simple "creator pays" model avoids all the heavy
overheads while maintaining the constraints.

Its only user space pages that some of this (AS and RSS) become
interesting as "movable" objects


