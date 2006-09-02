Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWIBNax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWIBNax (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 09:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWIBNax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 09:30:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6336 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751073AbWIBNaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 09:30:52 -0400
Date: Sat, 2 Sep 2006 09:30:03 -0400
From: Dave Jones <davej@redhat.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Jeff Chua <jeff.chua.linux@gmail.com>, Jens Axboe <axboe@kernel.dk>,
       Sreenivas.Bagalkote@lsil.com, Sumant.Patro@lsil.com, jeff@garzik.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: megaraid_sas suspend ok, resume oops
Message-ID: <20060902133003.GB6108@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	Jeff Chua <jeff.chua.linux@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Sreenivas.Bagalkote@lsil.com, Sumant.Patro@lsil.com,
	jeff@garzik.org, lkml <linux-kernel@vger.kernel.org>
References: <b6a2187b0608281004g30706834r96d5d24f85e82cc9@mail.gmail.com> <b6a2187b0608290522vea22930y54ac39bfce3127f2@mail.gmail.com> <1156895131.3232.25.camel@nigel.suspend2.net> <200608301054.56375.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608301054.56375.rjw@sisk.pl>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2006 at 10:54:56AM +0200, Rafael J. Wysocki wrote:

 > > > But without 64 bit support, my notebook will suspend/resume many times
 > > > without failing (with the 5 ahci patches from Pavel Machek)....
 > > 
 > > Neither swsusp (as far as I know) or suspend2 support CONFIG_HIGHMEM64G
 > > at the moment, I'm afraid.
 > > 
 > > It's not impossible, we just haven't seen it as a priority worth putting
 > > time into.
 > 
 > It looks like the Fedora default config has HIGHMEM64G set, so I'll be looking
 > at it shortly.

There is no 'Fedora default config'. We ship a number of different kernels,
some of which enable PAE, some disable it.

For FC5, the installer installs a PAE kernel if you have >4GB, or SMP.
For FC6, it'll only install one if you have >4GB.
(or possibly if you have an NX capable CPU, I forget if we enabled that
 magick in the installer)

Precluding NX support + swsusp kinda sucks, but I guess it's a tiny subset of users.

		Dave

-- 
http://www.codemonkey.org.uk

-- 
VGER BF report: H 0.120995
