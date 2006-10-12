Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422853AbWJLKFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422853AbWJLKFn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 06:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422858AbWJLKFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 06:05:42 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:59082 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1422853AbWJLKFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 06:05:42 -0400
Date: Thu, 12 Oct 2006 03:04:12 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Arjan van de Ven <arjan@infradead.org>
cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 18/67] zone_reclaim: dynamic slab reclaim
In-Reply-To: <1160638274.3000.411.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0610120302310.18163@schroedinger.engr.sgi.com>
References: <20061011204756.642936754@quad.kroah.org>  <20061011210453.GS16627@kroah.com>
 <1160638274.3000.411.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006, Arjan van de Ven wrote:

> this one adds a feature rather than a bugfix........ 

The existing slab reclaim "feature" in zone reclaim was not working 
right (was done earlier when no good VM statistics were available). This 
makes it work but we had to do some minor things differently.

