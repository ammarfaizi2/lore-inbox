Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWGYTGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWGYTGy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWGYTGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:06:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1978 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964808AbWGYTGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:06:53 -0400
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
From: Arjan van de Ven <arjan@infradead.org>
To: Neil Horman <nhorman@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
In-Reply-To: <20060725190357.GG4608@hmsreliant.homelinux.net>
References: <20060725174100.GA4608@hmsreliant.homelinux.net>
	 <1153850139.8932.40.camel@laptopd505.fenrus.org>
	 <20060725182208.GD4608@hmsreliant.homelinux.net>
	 <1153852375.8932.41.camel@laptopd505.fenrus.org>
	 <20060725184328.GF4608@hmsreliant.homelinux.net>
	 <1153853596.8932.44.camel@laptopd505.fenrus.org>
	 <20060725190357.GG4608@hmsreliant.homelinux.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 25 Jul 2006 21:06:52 +0200
Message-Id: <1153854412.8932.46.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > well the idea that has been tossed about a few times is using a vsyscall
> > function that either calls into the kernel, or directly uses the hpet
> > page (which can be user mapped) to get time information that way... 
> > or even would use rdtsc in a way the kernel knows is safe (eg corrected
> > for the local cpu's speed and offset etc etc).
> > 
> Ok, that makes sense, although thats only going to be supportable on hpet
> enabled systems right?  

well it's only going to be *fast* on hpet enabled systems (which should
be the *vast* majority nowadays if it wasn't for some silly bios
defaults by some vendors); all others can just fall back to other
methods. The beauty of the vsyscall concept :)


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

