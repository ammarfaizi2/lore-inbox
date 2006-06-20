Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965150AbWFTIni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965150AbWFTIni (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbWFTIni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:43:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61381 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965150AbWFTInh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:43:37 -0400
Subject: Re: [patch] increase spinlock-debug looping timeouts (write_lock
	and NMI)
From: Arjan van de Ven <arjan@infradead.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Dave Olson <olson@unixfolk.com>,
       mingo@elte.hu, ccb@acm.org, linux-kernel@vger.kernel.org
In-Reply-To: <4497A5BC.4070005@yahoo.com.au>
References: <fa.VT2rwoX1M/2O/aO5crhlRDNx4YA@ifi.uio.no>
	 <fa.Zp589GPrIISmAAheRowfRgZ1jgs@ifi.uio.no>
	 <Pine.LNX.4.61.0606192231380.25413@osa.unixfolk.com>
	 <20060619233947.94f7e644.akpm@osdl.org>  <4497A5BC.4070005@yahoo.com.au>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 10:43:12 +0200
Message-Id: <1150792992.2891.168.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 17:37 +1000,
> 
> Otherwise, a straight rwlock->spinlock conversion will have a few more
> scalability issues, but I'd guess it wouldn't be a problem  at all for
> most workloads on most systems.

I'm curious what scalability advantage you see for rw spinlocks vs real
spinlocks ... since for any kind of moderate hold time the opposite is
expected ;)


