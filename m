Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWHRRqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWHRRqB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 13:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWHRRqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 13:46:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25475 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751442AbWHRRqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 13:46:00 -0400
Date: Fri, 18 Aug 2006 10:45:47 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Thomas Klein <osstklei@de.ibm.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
       Jan-Bernd Themann <ossthema@de.ibm.com>, netdev@vger.kernel.org,
       Christoph Raisch <raisch@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: Re: [2.6.19 PATCH 4/7] ehea: ethtool interface
Message-ID: <20060818104547.5ad1352f@localhost.localdomain>
In-Reply-To: <44E5DFA6.7040707@de.ibm.com>
References: <200608181333.23031.ossthema@de.ibm.com>
	<20060818140506.GC5201@martell.zuzino.mipt.ru>
	<44E5DFA6.7040707@de.ibm.com>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2006 17:41:26 +0200
Thomas Klein <osstklei@de.ibm.com> wrote:

> Hi Alexey,
> 
> first of all thanks a lot for the extensive review.
> 
> 
> Alexey Dobriyan wrote:
> >> +	u64 hret = H_HARDWARE;
> > 
> > Useless assignment here and everywhere.
> > 
> 
> Initializing returncodes to errorstate is a cheap way to prevent
> accidentally returning (uninitalized) success returncodes which
> can lead to catastrophic misbehaviour.

That is old thinking. Current compilers do live/dead analysis
and tell you about this at compile time which is better than relying
on default behavior at runtime.
