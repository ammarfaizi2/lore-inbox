Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWGRMCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWGRMCU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 08:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWGRMCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 08:02:20 -0400
Received: from the.earth.li ([193.201.200.66]:56807 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id S1751327AbWGRMCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 08:02:19 -0400
Date: Tue, 18 Jul 2006 13:02:17 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Status of HPT372A driver?
Message-ID: <20060718120217.GF1485@earth.li>
References: <20060717142705.GS1485@earth.li> <44BBC75A.2000800@ru.mvista.com> <20060717182633.GX1485@earth.li> <44BBDFBE.10800@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44BBDFBE.10800@ru.mvista.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2006 at 11:06:38PM +0400, Sergei Shtylyov wrote:
> >I've had a try with libata and Alan Cox's 2.6.17-ide1 patch (I'd
> >previously tried this and had issues, which turned out to be a faulty
> >drive I think). This seems to get better results (sda is the same drive
> >as was hde earlier):
> 
>    I wouldn't be so sure about the faulty drive. ;-)

No, the drive was definitely faulty - I ran the Western Digital test
tool on it and it indicated the drive should be returned for a
replacement.
 
>    No "HW reset results" -- SATA drives don't have valid word 93 as it 
>    seems, and so the eighty_ninty_three() returns 0 meaning that the device 
> reports 40c PATA cable.
>    I think you need to try this 2.6.18-rc1 patch from Alan:
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=1a1276e7b6cba549553285f74e87f702bfff6fac

Result! I've applied that patch and now get UDMA(133) reported and
speeds of 45MB/s+, so much better. Thanks!

J.

-- 
                                            jid: noodles@jabber.earth.li
"Then P=NP, and the world is a happier
                                            place." -- Steve Cameron
in a complexity tute.
