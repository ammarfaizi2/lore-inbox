Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265909AbUJLMVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265909AbUJLMVp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 08:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266181AbUJLMVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 08:21:44 -0400
Received: from dyn3.mc.tuwien.ac.at ([128.130.175.85]:27269 "EHLO
	mail.13thfloor.at") by vger.kernel.org with ESMTP id S265909AbUJLMVm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 08:21:42 -0400
Date: Tue, 12 Oct 2004 14:27:33 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       chrisw@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/3] lsm: add bsdjail module
Message-ID: <20041012122733.GD8012@DUMA.13thfloor.at>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
	chrisw@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1097094103.6939.5.camel@serge.austin.ibm.com> <1097094270.6939.9.camel@serge.austin.ibm.com> <20041006162620.4c378320.akpm@osdl.org> <20041007190157.GA3892@IBM-BWN8ZTBWA01.austin.ibm.com> <20041010104113.GC28456@infradead.org> <1097502444.31259.19.camel@localhost.localdomain> <20041012070055.GB7003@DUMA.13thfloor.at> <20041012090057.GA15706@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041012090057.GA15706@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 10:00:57AM +0100, Christoph Hellwig wrote:
> On Tue, Oct 12, 2004 at 09:00:55AM +0200, Herbert Poetzl wrote:
> > and it works well, because we use it for almost
> > a year now on linux-vserver ;)
> 
> Btw, could anyone explain the exact differences between linux-vserver
> and this jail module?

hmm, okay I'll try ...

linux-vserver is a combination of kernel patch and
userspace tools to create 'virtual servers' similar
to UML, but sharing the resources (and kernel).

to do this, it uses process isolation, network
isolation and disk space separation (tagging). 
in addition it does resource management (accounting
and limits) for various aspects (CPU, memory, 
processes, sockets, filehandles, ...)

the jail module is recreating a limited subset of
the isolation aspect via LSM (similar to the BSD
jail) which allows to confine a process (and it's
children) to a chroot() environment under certain
limitations (resources)

best,
Herbert

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
