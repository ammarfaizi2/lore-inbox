Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265400AbUBPHfp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 02:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265413AbUBPHfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 02:35:44 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:12168 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S265400AbUBPHfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 02:35:38 -0500
From: Michael Frank <mhf@linuxmail.org>
To: Bill Anderson <banderson@hp.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: system (not HW) clock advancing really fast
Date: Mon, 16 Feb 2004 15:45:09 +0800
User-Agent: KMail/1.5.4
References: <1076910368.25980.12.camel@perseus> <200402161424.49242.mhf@linuxmail.org> <1076916391.25980.23.camel@perseus>
In-Reply-To: <1076916391.25980.23.camel@perseus>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402161545.09901.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 February 2004 15:26, Bill Anderson wrote:
> On Sun, 2004-02-15 at 23:24, Michael Frank wrote:
> > I had this somtetimes when using ntpd doing step time update
> > resulting in silly values in /etc/adjtime . 
> > 
> > # mv /etc/adjtime /tmp 
> > # hwclock --systohc
> > 
> > and see if it goes away.
> 
> Thanks, though it didn't work. :(
> 

Please check your /etc/ntp/drift , the value in it is
usually between -30.0 and 30.0

If it is much larger than that, set it to 0.0 and restart ntpd.

Also move /etc/adjtime away again.

Regards
Michael


