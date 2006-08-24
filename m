Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWHXBdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWHXBdt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 21:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965333AbWHXBdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 21:33:49 -0400
Received: from smtp-out.google.com ([216.239.45.12]:19002 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S965330AbWHXBdr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 21:33:47 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=ipgIY8eFYJrDuC+kBe5sKtjiBgTX/roKBxuU2FnyCyPYth/c8lo/Ilnffn/vkDvdX
	nDPMy3uXtCUmV+QrdAFtg==
Subject: Re: [ckrm-tech] [RFC][PATCH] UBC: user resource beancounters
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: sekharan@us.ibm.com, Kirill Korotaev <dev@sw.ru>,
       Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1156240970.27114.5.camel@localhost.localdomain>
References: <44E33893.6020700@sw.ru>
	 <1155929992.26155.60.camel@linuxchandra>  <44E9B3F5.3010000@sw.ru>
	 <1156196721.6479.67.camel@linuxchandra>
	 <1156211128.11127.37.camel@galaxy.corp.google.com>
	 <1156240970.27114.5.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 23 Aug 2006 18:31:26 -0700
Message-Id: <1156383086.8324.39.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-22 at 11:02 +0100, Alan Cox wrote:
> Ar Llu, 2006-08-21 am 18:45 -0700, ysgrifennodd Rohit Seth:
> > I think as the tasks move around, it becomes very heavy to move all the
> > pages belonging to previous container to a new container.
> 
> Its not a meaningful thing to do. Remember an object may be passed
> around or shared. The simple "creator pays" model avoids all the heavy
> overheads while maintaining the constraints.
> 

I agree, creator pays model will be good for anonymous pages.  (And this
is where page based container will help).

> Its only user space pages that some of this (AS and RSS) become
> interesting as "movable" objects
> 

I think something like for AS, yes.  But for anonymous pages, might want
to leave them back.

-rohit


