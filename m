Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268378AbUIWKgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268378AbUIWKgl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 06:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268379AbUIWKgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 06:36:41 -0400
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:53667 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S268378AbUIWKgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 06:36:39 -0400
Message-ID: <4152A72E.8050404@kolivas.org>
Date: Thu, 23 Sep 2004 20:36:30 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, ck kernel mailing list <ck@vds.kolivas.org>
Subject: [PATCH] Staircase scheduler v8.6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated the staircase cpu scheduler. This version is the first in the 
next development phase I've been leading it towards - removing 
dependency on scheduler_tick to make it suitable for a tickless kernel.

v8.6 removes all timeslice expiration from scheduler_tick and does this 
with an on-demand timer of it's own. Currently this does not offer any 
major advantage over the previous version, but once more of the code is 
removed from scheduler_tick and there is a mechanism for more accurate 
timers not dependant on jiffies it will offer better accuracy, lower 
overhead and low power advantages.

Rolled up and split patches for 2.6.9-rc2-mm2 available here:

http://ck.kolivas.org/patches/2.6/2.6.9/2.6.9-rc2-mm2/

rolled up patch:
from_2.6.9-rc2-mm2_to_staircase8.6

is a combination of:
#back-zaphod.patch
#from_2.6.9-rc2_to_staircase8.4
#s8.4_fixhotplug.diff
#s8.4-expiration_notick.diff

Cheers,
Con

P.S. I will be offline for a week as of tomorrow.
