Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270353AbUJTNba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270353AbUJTNba (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 09:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270199AbUJTN3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 09:29:06 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:41656 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S270205AbUJTN2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 09:28:05 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=AjCDsMytNQT0RXnACYSX1BpP6/udUZQGSl+wAopm4cnDAn4Culy1uZQBbew2vAzdnCMQDnS9eD/rqK7aVfICI7L1Ipv/e4BP7X61CB55yKkv8c6d3QOu54cb/rsElZbJOWf5rEG3E9xYLv09ihtt7H/sMPws8iwmCVNVagexpAY
Message-ID: <2c59f003041020062877c53539@mail.gmail.com>
Date: Wed, 20 Oct 2004 18:58:04 +0530
From: Amit Gud <amitgud1@gmail.com>
Reply-To: Amit Gud <amitgud1@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, Amit Gud <amitgud1@gmail.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Remove union u from linux/fs.h
In-Reply-To: <20041020131015.GB20287@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <2c59f00304102002135ca68dd0@mail.gmail.com>
	 <20041020131015.GB20287@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Give me one simple use of that union except for the sake of backward
compatibilty. BTW, all stable kernels, I guess, definitely make
something or the other incompatible.

Though removing it is no smartness, there is no point in keeping dead
remains of the past, especially if it makes us look dumb.

AG


On Wed, 20 Oct 2004 14:10:15 +0100, Christoph Hellwig <hch@infradead.org> wrote:
> On Wed, Oct 20, 2004 at 02:43:59PM +0530, Amit Gud wrote:
> > Do we need the foolish-looking union with just single entry (void
> > *generic_ip) in the struct inode linux/fs.h anymore? Why not remove
> > it?
> >
> > This patch does that along with the changes in other parts of the
> > kernel that references the union. Its compile-tested and applies
> > cleanly to 2.6.9 vanilla.
> 
> I don't think we shoould do such purely cosmetic changes that break backwards
> compatibility during stable series.
> 
>
