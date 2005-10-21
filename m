Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965092AbVJUSvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbVJUSvU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 14:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbVJUSvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 14:51:19 -0400
Received: from 66.64.135.114.nw.nuvox.net ([66.64.135.114]:58502 "EHLO
	service.eng.exegy.net") by vger.kernel.org with ESMTP
	id S965082AbVJUSvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 14:51:18 -0400
Message-ID: <4359389E.6030406@exegy.com>
Date: Fri, 21 Oct 2005 13:51:10 -0500
From: "Mr. Berkley Shands" <bshands@exegy.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1.centos4 (X11/20050721)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc5 mlock/munlock bug
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2005 18:55:08.0296 (UTC) FILETIME=[F4E07880:01C5D670]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed that between 2.6.14-rc2 and 2.6.14-rc5 mlock() and 
mlunlock() have broken.

a call to mlock() to lock pages is granted, and the pages are locked, 
but never
unlocked, even when munlock() is manually called or at process rundown.
No problems under 2.6.13 or up to 2.6.14-rc2. But sometime after -rc2 it 
goes BANG
and the machine gets very unhappy. If you look at "swapon -s" you see 
more and more swap
space is used until there is no physical memory left, then things really 
get unhappy.

berkley
