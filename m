Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbUCROFR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 09:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbUCROFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 09:05:16 -0500
Received: from mail.netbeat.de ([193.254.185.26]:37014 "HELO mail.netbeat.de")
	by vger.kernel.org with SMTP id S262650AbUCROE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 09:04:27 -0500
From: <Baecker@IRF.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3/scsi: Unexpected busfree while idle
Date: Thu, 18 Mar 2004 15:03:53 +0100
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200403181503.53980.Baecker@IRF.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hi all,
> 
> what does the following message mean (during scsi init at boot)?
> 
> scsi0: Unexpected busfree while idle
> SEQADDR == 0x1
> 
> It appears each second or so, and the system can't move on. It only 
happens if 
> a specific drive is on the scsi bus.
> 
> Does it mean that drive is broken?

Not necessarily. It might just fail to meet the timing specification the 
controller is demanding.
A similar effect occured with my scanner attached to a adaptec 
controller. BTW, which brand is your controller? 

> The scsi bios (during system bootup, before linux) detects all discs 
properly 
> (including this one), and in the scsi bios i can "veryfiy media" and 
it 
> doesn't complain.


You might want to try whether the following is working - within the 
computers BIOS setup disable both external and internal caching 
temporarily. This makes the system extremely sloooooooooooow - but it 
made my scanner working. (That's no solution, of course!  --  Just a 
way to trace the problem.)

 
> Thanks in advance,
> 
> 	Florian


Hope it works,

Thomas
