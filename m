Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbVHHPIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVHHPIg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 11:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbVHHPIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 11:08:36 -0400
Received: from keetweej.xs4all.nl ([213.84.46.114]:35756 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S1750940AbVHHPIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 11:08:35 -0400
Date: Mon, 8 Aug 2005 17:08:30 +0200
From: Folkert van Heusden <folkert@vanheusden.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       vatsa@in.ibm.com, ck@vds.kolivas.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com, george@mvista.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 5
Message-ID: <20050808150829.GW22838@vanheusden.com>
References: <200508031559.24704.kernel@kolivas.org>
	<200508060239.41646.kernel@kolivas.org>
	<20050806174739.GU4029@stusta.de>
	<200508071512.22668.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508071512.22668.kernel@kolivas.org>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Mon Aug  8 22:08:29 CEST 2005
X-MSMail-Priority: High
X-Message-Flag: MultiTail - tail on steroids
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are there any tools for checking the current number of ticks?
I currently do:
#!/bin/sh

S1=`cat /proc/interrupts | grep "^  0: " | awk '{ print $2; }'`
sleep 1
S2=`cat /proc/interrupts | grep "^  0: " | awk '{ print $2; }'`
echo $((S2-S1))

But that gives me output like this on a quiet system with only firefox,
a couple of gnometerms and a bittorrent downloader values like:
folkert@ehm:~$ for i in `seq 1 10` ; do ./ticks ; done
566
511
630
501
522
533
503
516
518
515
which I find quiet high, aren't they?


On Sun, Aug 07, 2005 at 03:12:21PM +1000, Con Kolivas wrote:
> Respin of the dynamic ticks patch for i386 by Tony Lindgen and Tuukka Tikkanen 
> with further code cleanups. Are were there yet?
> 
> Cheers,
> Con
> ---
> 
> 


Folkert van Heusden

-- 
Auto te koop, zie: http://www.vanheusden.com/daihatsu.php
--------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
--------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE
