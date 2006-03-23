Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWCWKSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWCWKSw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 05:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWCWKSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 05:18:52 -0500
Received: from webmailv3.ispgateway.de ([80.67.16.113]:64919 "EHLO
	webmailv3.ispgateway.de") by vger.kernel.org with ESMTP
	id S932179AbWCWKSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 05:18:51 -0500
Message-ID: <1143109112.442275f83c95e@www.domainfactory-webmail.de>
Date: Thu, 23 Mar 2006 11:18:32 +0100
From: Clemens Ladisch <clemens@ladisch.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: abergman@de.ibm.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] hpet header sanitization
References: <20060321144607.153d1943.rdunlap@xenotime.net> <200603221118.43853.abergman@de.ibm.com> <20060322111446.GA7675@turing.informatik.uni-halle.de> <20060322090125.8fc13711.rdunlap@xenotime.net>
In-Reply-To: <20060322090125.8fc13711.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 213.238.46.206
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Wed, 22 Mar 2006 12:14:46 +0100 Clemens Ladisch wrote:
> > There isn't any program (except the example in the docs) that
> > uses any of these ioctls, and I'm writing patches to make this
> > device available through portable timer APIs like hrtimer/POSIX
> > clocks/ALSA that are much easier to use besides, so I think it
> > would be a good idea to just schedule these ioctls for removal.
>
> How do you (or can you) know that there are no programs that use
> that ioctl?

Because most parts of hpet.c were orignially written on an emulator
and were so buggy as to be effectively unusable until recently.

Additionally, there aren't many BIOSes out there that manage to
initialize the third HPET timer (the one used by these ioctls)
correctly, or that bother to enable the HPET device at all.  (This
seems to be changing due to the Windows Vista logo requirements.)


Regards,
Clemens

