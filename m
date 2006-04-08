Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWDHI0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWDHI0f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 04:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWDHI0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 04:26:35 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:27570 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751398AbWDHI0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 04:26:34 -0400
Date: Sat, 8 Apr 2006 10:26:14 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andreas Schwab <schwab@suse.de>
cc: Neil Brown <neilb@suse.de>, Tony Luck <tony.luck@gmail.com>,
       Mike Hearn <mike@plan99.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Add a /proc/self/exedir link
In-Reply-To: <jeirplrbka.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.61.0604081026040.21887@yvahk01.tjqt.qr>
References: <4431A93A.2010702@plan99.net> <m1fykr3ggb.fsf@ebiederm.dsl.xmission.com>
 <44343C25.2000306@plan99.net> <12c511ca0604061633p2fb1796axd5acad8373532834@mail.gmail.com>
 <17462.6689.821815.412458@cse.unsw.edu.au> <jeirplrbka.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> It leaks information about the parts of the pathname below the
>>> directory that you otherwise would not be able to see.  E.g. if
>>> I have $HOME/top-secret-projects/secret-code-name1/binary
>>> where the top-secret-projects directory isn't readable by you,
>>> then you may find out secret-code-name1 by reading the
>>> /proc/{pid}/exedir symlink.
>>
>> But we already have /proc/{pid}/exe which is a symlink to the
>> executable, thus exposing all the directory names already.

In which case the administrator of the machine should make /proc/xyz
directories mode 0700. (Patches are floating around.)


Jan Engelhardt
-- 
