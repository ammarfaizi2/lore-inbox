Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbVLYASU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVLYASU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 19:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbVLYASU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 19:18:20 -0500
Received: from lucidpixels.com ([66.45.37.187]:59521 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1750761AbVLYAST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 19:18:19 -0500
Date: Sat, 24 Dec 2005 19:18:18 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Mark Lord <lkml@rtr.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc6 - Success with ICH5/SATA + S.M.A.R.T.
In-Reply-To: <43ADDD34.9020101@rtr.ca>
Message-ID: <Pine.LNX.4.64.0512241915370.5009@p34>
References: <Pine.LNX.4.64.0512241830010.2700@p34> <43ADDD34.9020101@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My mistake,

Was adding the option in the wrong place.

In the smartd.conf file, add the -d ata option here:

/dev/sda -d ata -H -l error -l selftest -t -I 194 -s (S/../.././02)
/dev/sdb -d ata -H -l error -l selftest -t -I 194 -s (S/../.././02)
/dev/hde -H -l error -l selftest -t -I 194 -s (S/../.././02)

Works now.

Thanks,

Justin.

On Sat, 24 Dec 2005, Mark Lord wrote:

>> smartmontools is going to have to be updated
>
> What for?
>
> Use "smartctl -d ata /dev/sda"
>
> -ml
>
