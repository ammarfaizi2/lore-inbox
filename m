Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWFYBAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWFYBAs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 21:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWFYBAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 21:00:48 -0400
Received: from asteria.debian.or.at ([86.59.21.34]:1508 "EHLO
	asteria.debian.or.at") by vger.kernel.org with ESMTP
	id S1751312AbWFYBAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 21:00:48 -0400
Date: Sun, 25 Jun 2006 03:00:47 +0200
From: Peter Palfrader <peter@palfrader.org>
To: linux-kernel@vger.kernel.org, openipmi-developer@lists.sourceforge.net
Subject: Re: [Openipmi-developer] BUG: soft lockup detected on CPU#1, ipmi_si
Message-ID: <20060625010047.GP3519@asteria.noreply.org>
Mail-Followup-To: Peter Palfrader <peter@palfrader.org>,
	linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net
References: <20060613233521.GO22999@asteria.noreply.org> <44962116.70302@acm.org> <20060619093851.GL27377@asteria.noreply.org> <449AA320.3060700@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <449AA320.3060700@acm.org>
X-PGP: 1024D/94C09C7F 5B00 C96D 5D54 AEE1 206B  AF84 DE7A AF6E 94C0 9C7F
X-Request-PGP: http://www.palfrader.org/keys/94C09C7F.asc
X-Accept-Language: de, en
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Corey Minyard wrote:

> Peter, can you make a code change for me and try something out?
> 
> If possible, could you change the call to udelay(1) in the function
> ipmi_thread() in drivers/char/ipmi_si_intf.c to be a call to schedule()
> instead?  I'm guessing that will fix this problem.

That appears to work.  I can still get sensor data using ipmitool, and I
haven't gotten any of the soft lockup warnings in 4 hours.

Thanks!
-- 
                           |  .''`.  ** Debian GNU/Linux **
      Peter Palfrader      | : :' :      The  universal
 http://www.palfrader.org/ | `. `'      Operating System
                           |   `-    http://www.debian.org/
