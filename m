Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWEWIw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWEWIw7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 04:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWEWIw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 04:52:59 -0400
Received: from www1.cdi.cz ([194.213.194.49]:58798 "EHLO www1.cdi.cz")
	by vger.kernel.org with ESMTP id S932112AbWEWIw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 04:52:58 -0400
Message-ID: <4472CD62.5060906@cdi.cz>
Date: Tue, 23 May 2006 10:52:50 +0200
From: Martin Devera <devik@cdi.cz>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: axboe@suse.de
CC: linux-kernel@vger.kernel.org
Subject: wrong in_flight diskstat in 2.6.16.1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I see weird output from /sys/block/sd{a,b}/stat on our AMD64-X2 smp 
machine with HT1000 (Broadcom) SATA with 2 WD 250GB HDDs in MD raid1. AS 
scheduler was used, change to noop didn't change anything. It is vanilla 
2.6.16.1 and here are absolute values in hex and one second differences 
below:

132CDF 56D62 61753C0 6966BC 165A8EB 5FF5B6C 3B32D6C0 1110594C FFCA89A4 
FEE85878 49FF74E4
132CDF 56D62 61753C0 6966BC 165A8EF 5FF5B6C 3B32D6E0 111059D0 FFCA89A1 
FEE85C60 79291244
  0: 0
  1: 0
  2: 0
  3: 0
  4: 4
  5: 0
  6: 32
  7: 132
  8: -3
  9: 1000
10: 791256416

As you can see in_flight is constantly negative and it is DECREASING 
slowly all the time.
I can't find any reason for it :-\

Martin Devera
