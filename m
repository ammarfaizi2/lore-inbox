Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWHPTHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWHPTHd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 15:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbWHPTHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 15:07:33 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:61413 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750887AbWHPTHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 15:07:32 -0400
Subject: Re: [RFC][PATCH] UBC: user resource beancounters
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: rohitseth@google.com
Cc: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
In-Reply-To: <1155754427.22595.88.camel@galaxy.corp.google.com>
References: <44E33893.6020700@sw.ru>
	 <1155754427.22595.88.camel@galaxy.corp.google.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Aug 2006 20:26:25 +0100
Message-Id: <1155756386.24077.398.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-16 am 11:53 -0700, ysgrifennodd Rohit Seth:
> >   pages shared between containers are correctly
> >   charged as fractions (tunable).
> > 
> 
> I wouldn't be too worried about doing fractions.  Make it unfair and
> charge it to either the container who first instantiated the file or the
> container who faulted on that page first.

Thats no good if you can arrange who gets charged, it becomes possible
to accumulate the advantages and break the constraints intended.

> Though the part that seems important is to be able to define a directory
> in fs and say all pages belonging to files underneath that directory are
> going to be put in specific container. 

Thats an extremely crude use of beancounters. You can do far more useful
things with them and namespaces (and even at times without namespaces)
such as preventing one web site breaking another.

