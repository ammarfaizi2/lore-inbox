Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbTFKUgn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 16:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbTFKUgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 16:36:13 -0400
Received: from lorien.emufarm.org ([66.93.131.57]:4843 "EHLO
	lorien.emufarm.org") by vger.kernel.org with ESMTP id S264505AbTFKUet
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 16:34:49 -0400
Date: Wed, 11 Jun 2003 13:48:28 -0700
From: Danek Duvall <duvall@emufarm.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc7-ac1
Message-ID: <20030611204828.GC8952@lorien.emufarm.org>
Mail-Followup-To: Danek Duvall <duvall@emufarm.org>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
References: <200306042248.h54Mm7l16828@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306042248.h54Mm7l16828@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried putting this on my Fujitsu Lifebook P2120 (Crusoe based), and it
freezes the system hard when using hwclock to sync the system clock with the
hardware clock.

Running hwclock under strace in the init script prints out it opening
/dev/rtc (for the second time), and then sometimes dying in the middle
of printing out the following ioctl: "ioctl(3, RTC_UIE_ON, 0)", and more
often in printing out the following read().

Removing the rtc module lets the system boot up.

2.4.21-rc7 works fine.  The config file I'm using can be found at

    http://lorien.emufarm.org/~duvall/.config

What bits should I start hacking away to narrow down the problem, or is
this known?

Thanks,
Danek
