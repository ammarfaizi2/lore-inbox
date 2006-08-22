Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWHVKzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWHVKzZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 06:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWHVKzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 06:55:25 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63645 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932165AbWHVKzY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 06:55:24 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH] UBC: user resource beancounters
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: rohitseth@google.com, sekharan@us.ibm.com, Kirill Korotaev <dev@sw.ru>,
       Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1156240668.2976.35.camel@laptopd505.fenrus.org>
References: <44E33893.6020700@sw.ru>
	 <1155929992.26155.60.camel@linuxchandra>  <44E9B3F5.3010000@sw.ru>
	 <1156196721.6479.67.camel@linuxchandra>
	 <1156211128.11127.37.camel@galaxy.corp.google.com>
	 <1156240970.27114.5.camel@localhost.localdomain>
	 <1156240668.2976.35.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Aug 2006 12:15:13 +0100
Message-Id: <1156245313.27114.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-22 am 11:57 +0200, ysgrifennodd Arjan van de Ven:
> there is one issue with the "creator pays" model: if the creator can
> decide to die/go away/respawn then you can create orphan resources. This

You cannot create orphan resources with UBC. All resources have an
owner. You might be able to construct a hypothetical scenario where I
commit all my resources to other people but I cannot create orphan
resources or leak them.

Even if I am the only user of a given UBC my counter will survive until
the last object is freed, not until I log out. If I log back in my
resource accounting is still there and nothing has escaped.

Alan



