Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268438AbUJTPrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268438AbUJTPrH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 11:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268404AbUJTPpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 11:45:04 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:17673 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268397AbUJTPga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 11:36:30 -0400
Date: Wed, 20 Oct 2004 16:36:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       chrisw@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/3] lsm: add bsdjail module
Message-ID: <20041020153621.GA21916@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
	chrisw@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1097094103.6939.5.camel@serge.austin.ibm.com> <1097094270.6939.9.camel@serge.austin.ibm.com> <20041006162620.4c378320.akpm@osdl.org> <20041007190157.GA3892@IBM-BWN8ZTBWA01.austin.ibm.com> <20041010104113.GC28456@infradead.org> <1097502444.31259.19.camel@localhost.localdomain> <20041012070055.GB7003@DUMA.13thfloor.at> <20041012090057.GA15706@infradead.org> <20041012122733.GD8012@DUMA.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041012122733.GD8012@DUMA.13thfloor.at>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 02:27:33PM +0200, Herbert Poetzl wrote:
> On Tue, Oct 12, 2004 at 10:00:57AM +0100, Christoph Hellwig wrote:
> > On Tue, Oct 12, 2004 at 09:00:55AM +0200, Herbert Poetzl wrote:
> > > and it works well, because we use it for almost
> > > a year now on linux-vserver ;)
> > 
> > Btw, could anyone explain the exact differences between linux-vserver
> > and this jail module?
> 
> hmm, okay I'll try ...
> 
> linux-vserver is a combination of kernel patch and
> userspace tools to create 'virtual servers' similar
> to UML, but sharing the resources (and kernel).
> 
> to do this, it uses process isolation, network
> isolation and disk space separation (tagging). 
> in addition it does resource management (accounting
> and limits) for various aspects (CPU, memory, 
> processes, sockets, filehandles, ...)
> 
> the jail module is recreating a limited subset of
> the isolation aspect via LSM (similar to the BSD
> jail) which allows to confine a process (and it's
> children) to a chroot() environment under certain
> limitations (resources)

So why

 a) can't linux-vserver use LSM hooks where applicable
 b) can't the two projects share code so we don't only have a crippled
    version in mainline

