Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030399AbWHRN4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030399AbWHRN4m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 09:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030407AbWHRN4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 09:56:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16291 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030399AbWHRN4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 09:56:41 -0400
Subject: Re: [2.6.19 PATCH 1/7] ehea: interface to network stack
From: Arjan van de Ven <arjan@infradead.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Jan-Bernd Themann <ossthema@de.ibm.com>, netdev@vger.kernel.org,
       Christoph Raisch <raisch@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <osstklei@de.ibm.com>, Thomas Klein <tklein@de.ibm.com>
In-Reply-To: <20060818134728.GB5201@martell.zuzino.mipt.ru>
References: <200608181329.02042.ossthema@de.ibm.com>
	 <20060818134728.GB5201@martell.zuzino.mipt.ru>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 18 Aug 2006 15:56:17 +0200
Message-Id: <1155909377.4494.192.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 17:47 +0400, Alexey Dobriyan wrote:
> On Fri, Aug 18, 2006 at 01:29:01PM +0200, Jan-Bernd Themann wrote:
> 
> Was there noticeable performance difference when explicit prefetching is
> removed? At some (invisible) point CPUs will become smarter about prefetching
> than programmers and this code will be slower than possible.

Hi,

what you say is true in general, however the packet response part of the
kernel is special; the cpu just cannot know where your card just dma'd
the packet to (and thus cleared it from any caches anywhere in the
system) so it's going to be pretty much a 100% cachemiss always...

Greetings,
   Arjan van de Ven

