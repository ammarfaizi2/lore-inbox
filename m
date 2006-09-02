Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbWIBULY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWIBULY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 16:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWIBULY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 16:11:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8083 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751500AbWIBULX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 16:11:23 -0400
Date: Sat, 2 Sep 2006 16:10:01 -0400
From: Dave Jones <davej@redhat.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Jeff Chua <jeff.chua.linux@gmail.com>, Jens Axboe <axboe@kernel.dk>,
       Sreenivas.Bagalkote@lsil.com, Sumant.Patro@lsil.com, jeff@garzik.org,
       lkml <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: megaraid_sas suspend ok, resume oops
Message-ID: <20060902201001.GC30379@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	Jeff Chua <jeff.chua.linux@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Sreenivas.Bagalkote@lsil.com, Sumant.Patro@lsil.com,
	jeff@garzik.org, lkml <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@ucw.cz>
References: <b6a2187b0608281004g30706834r96d5d24f85e82cc9@mail.gmail.com> <200608301054.56375.rjw@sisk.pl> <20060902133003.GB6108@redhat.com> <200609022147.05503.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609022147.05503.rjw@sisk.pl>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 02, 2006 at 09:47:05PM +0200, Rafael J. Wysocki wrote:

 > > Precluding NX support + swsusp kinda sucks, but I guess it's a tiny subset of users.
 > 
 > Well, I think the majority of NX-capable CPUs are also x86_64, in which case
 > I'd recommend using a 64-bit kernel anyway.

There's a fairly large number of these "Core Duo" systems out there :)
Hopefully these are the last CPUs lacking longmode that Intel will make.
Asides from these, the only other 32-bit only CPUs with NX are the newer VIA C3s.

For the Fedora users it's not that big a deal not being able to take advantage
of NX, as we fall back to using the old segment limit tricks that exec-shield
does to emulate NX, without having to worry about PAE headaches.

Given the only other use of PAE is >4GB support, and these systems typically
max out at 4GB due to the limited number of memory slots, it's not really that
big a problem.

 > I was afraid the issue would be urgent, but it doesn't seem so now.  I'd like to
 > postpone fixing it until we can create suspend images larger that 350 meg on
 > i386 boxes with highmem (the patch is ready to go to -mm after 2.6.19-rc1 as
 > 2.6.20 material).

Sounds good to me.

		Dave

-- 
http://www.codemonkey.org.uk

-- 
VGER BF report: H 0.178966
