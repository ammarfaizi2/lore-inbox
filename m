Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751570AbWHRXCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbWHRXCA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 19:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbWHRXCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 19:02:00 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:32939 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751569AbWHRXB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 19:01:59 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH] UBC: user resource beancounters
From: Matt Helsley <matthltc@us.ibm.com>
To: "Chandra S. Seetharaman" <sekharan@us.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, Rik van Riel <riel@redhat.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1155927229.26155.28.camel@linuxchandra>
References: <44E33893.6020700@sw.ru> <20060817110237.GA19127@in.ibm.com>
	 <44E47547.8030702@sw.ru> <1155844543.26155.10.camel@linuxchandra>
	 <44E5982C.80304@sw.ru>  <1155927229.26155.28.camel@linuxchandra>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 15:55:28 -0700
Message-Id: <1155941729.2510.376.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 11:53 -0700, Chandra Seetharaman wrote:
> On Fri, 2006-08-18 at 14:36 +0400, Kirill Korotaev wrote:

<snip>

> > 2. as was discussed with a number of people on summit we agreed that
> >    it maybe more flexible to not merge all resource types into one set.
> >    CPU scheduler is usefull by itself w/o memory management.
> >    the same for disk I/O bandwidht which is controlled in CFQ by
> >    a separate system call.
> > 
> >    it is also more logical to have them separate since they
> >    operate in different terms. For example, for CPU it is
> >    shares which are relative units, while for memory it is
> >    absolute units in bytes.
> 
> We don't have to tie the units with the number. We can leave it to be
> sorted out between the user and the controller writer.

Yes. The user specifies a ratio of the parent group's resources and the
controller maps that unitless number into appropriate units for the
resource.

> Current implementation of resource groups does that.

IMHO this also better facilitates hotplug addition/removal of resources,
arbitrary levels of groups, and containers.

<snip>

Cheers,
	-Matt Helsley

