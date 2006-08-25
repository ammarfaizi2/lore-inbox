Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWHYOsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWHYOsc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWHYOsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:48:32 -0400
Received: from ns2.suse.de ([195.135.220.15]:7896 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932460AbWHYOsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:48:31 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] BC: resource beancounters (v2)
Date: Fri, 25 Aug 2006 16:48:00 +0200
User-Agent: KMail/1.9.3
Cc: Kirill Korotaev <dev@sw.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Greg KH <greg@kroah.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       Matt Helsley <matthltc@us.ibm.com>, Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
References: <44EC31FB.2050002@sw.ru> <44EEE3BB.10303@sw.ru> <20060825073003.e6b5ae16.akpm@osdl.org>
In-Reply-To: <20060825073003.e6b5ae16.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608251648.00033.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> D) Virtual scan of mm's in the over-limit container
> 
> E) Modify existing physical scanner to be able to skip pages which
>    belong to not-over-limit containers.

The same applies to dentries/inodes too, doesn't it? But their
scan is already virtual so their LRUs could be just split into
a per container list (but then didn't Christoph L. plan to 
rewrite that code anyways?)

For memory my guess would be that (E) would be easier than (D) for user/file
memory though less efficient.

-Andi
