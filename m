Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262326AbVCVHqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbVCVHqW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 02:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbVCVHqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 02:46:22 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:58784 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262326AbVCVHqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 02:46:14 -0500
Date: Tue, 22 Mar 2005 08:46:12 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Short sleep precision
In-Reply-To: <423EF7B5.2030507@nortel.com>
Message-ID: <Pine.LNX.4.61.0503220845150.2969@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0503201316320.18044@yvahk01.tjqt.qr>
 <Pine.LNX.4.62.0503201335420.2501@dragon.hyggekrogen.localhost>
 <Pine.LNX.4.61.0503201427010.31416@yvahk01.tjqt.qr> <423EF7B5.2030507@nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

>> > You can spin on the gettimeofday() result in userspace.
>> How can I use it?
> Something like:
>
> gettimeofday(&curtime,0);
> add_usecs(&curtime,  time_to_sleep);
> do {
> 	gettimeofday(&curtime,0);
> } while (time_before(&curtime, &expiry);

That's looks like a lot of CPU consumption, which I would like to avoid 
because time_to_sleep is nondeterministic in my case.


Jan Engelhardt
-- 
