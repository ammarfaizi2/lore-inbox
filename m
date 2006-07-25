Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWGYTQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWGYTQG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbWGYTQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:16:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39337 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964820AbWGYTQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:16:04 -0400
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
From: Arjan van de Ven <arjan@infradead.org>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Neil Horman <nhorman@tuxdriver.com>, linux-kernel@vger.kernel.org,
       a.zummo@towertech.it, jg@freedesktop.org
In-Reply-To: <20060725190743.GB31334@tuxdriver.com>
References: <20060725174100.GA4608@hmsreliant.homelinux.net>
	 <1153850139.8932.40.camel@laptopd505.fenrus.org>
	 <20060725182208.GD4608@hmsreliant.homelinux.net>
	 <1153852375.8932.41.camel@laptopd505.fenrus.org>
	 <20060725184328.GF4608@hmsreliant.homelinux.net>
	 <1153853596.8932.44.camel@laptopd505.fenrus.org>
	 <20060725190743.GB31334@tuxdriver.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 25 Jul 2006 21:16:02 +0200
Message-Id: <1153854962.8932.49.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-25 at 15:07 -0400, John W. Linville wrote:
> On Tue, Jul 25, 2006 at 08:53:16PM +0200, Arjan van de Ven wrote:
> > On Tue, 2006-07-25 at 14:43 -0400, Neil Horman wrote:
> 
> > > alternative, which, as I mentioned before I would be happy to take a crack at,
> > > if you would elaborate on your idea a little more.
> > 
> > well the idea that has been tossed about a few times is using a vsyscall
> > function that either calls into the kernel, or directly uses the hpet
> > page (which can be user mapped) to get time information that way... 
> > or even would use rdtsc in a way the kernel knows is safe (eg corrected
> > for the local cpu's speed and offset etc etc).
> 
> Aren't both of those examples x86(_64)-specific?  Wouldn't a generic
> solution be preferrable?

the implementation is; the interface.. not so. other platforms can
implement their optimal solution obviously...


