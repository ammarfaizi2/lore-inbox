Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVCVPWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVCVPWI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 10:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVCVPWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 10:22:08 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:35020 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261369AbVCVPUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 10:20:15 -0500
Date: Tue, 22 Mar 2005 16:19:16 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Chris Friesen <cfriesen@nortel.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Short sleep precision
In-Reply-To: <424036AE.1040404@nortel.com>
Message-ID: <Pine.LNX.4.61.0503221618290.22440@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0503201316320.18044@yvahk01.tjqt.qr>
 <Pine.LNX.4.62.0503201335420.2501@dragon.hyggekrogen.localhost>
 <Pine.LNX.4.61.0503201427010.31416@yvahk01.tjqt.qr> <423EF7B5.2030507@nortel.com>
 <Pine.LNX.4.61.0503220845150.2969@yvahk01.tjqt.qr> <424036AE.1040404@nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> That's looks like a lot of CPU consumption, which I would like to avoid
>> because time_to_sleep is nondeterministic in my case.
>
> If you want to delay for less than a tick, you pretty much need to busy-wait.
> There's no way to set a timer for intervals less than a tick in the regular
> kernel.[...]

I bet I stay with my current approach -- count the time we actually slept, and 
sleep less the next time. Thanks for your time and thoughts!


Jan Engelhardt
-- 
