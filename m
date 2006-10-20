Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWJTS06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWJTS06 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 14:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWJTS06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 14:26:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20917 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964805AbWJTS05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 14:26:57 -0400
Date: Fri, 20 Oct 2006 11:26:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de
Cc: teunis <teunis@wintersgift.com>, linux-kernel@vger.kernel.org,
       Dmitry Torokhov <dtor@mail.ru>, Ingo Molnar <mingo@elte.hu>
Subject: Re: various laptop nagles - any suggestions?   (note:
 2.6.19-rc2-mm1 but applies to multiple kernels)
Message-Id: <20061020112627.04a4035a.akpm@osdl.org>
In-Reply-To: <1161368034.5274.278.camel@localhost.localdomain>
References: <4537A25D.6070205@wintersgift.com>
	<20061019194157.1ed094b9.akpm@osdl.org>
	<4538F9AD.8000806@wintersgift.com>
	<20061020110746.0db17489.akpm@osdl.org>
	<1161368034.5274.278.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 20:13:54 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> > Also, NO_HZ breaks my laptop (and presumably quite a few others) quite
> > horridly, which means nobody can ship the feature.  Some runtime
> > turn-it-off work needs to be done there.
> 
> We can make a commandline switch as for highres. Is that sufficient ?

I doubt it.

I don't know how many machines will be affected by this, but I'd expect
it's quite a few - the Vaio has a less-than-one-year-old Intel CPU in it.

I'd expect that if a distro were to enable NO_HZ, they'd have a large
number of unhappy users whose machines run like crap, some of whom would
find out that they need to add some funny dont-run-like-crap option and
some of whom would, after wasting considerable amounts of time, just give
up and use windows or RH5.2 or something.

IOW, it would be vastly better to make it simply work out-of-the-box.
