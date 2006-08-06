Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWHFPcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWHFPcP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 11:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWHFPcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 11:32:15 -0400
Received: from kludge.physics.uiowa.edu ([128.255.33.129]:12813 "EHLO
	kludge.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id S932075AbWHFPcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 11:32:14 -0400
Date: Sun, 6 Aug 2006 10:35:08 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: IO errors after some uptime on 2.6.17.7
Message-ID: <20060806153508.GB5157@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: Chuck Ebbert <76306.1226@compuserve.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200608060300_MC3-1-C736-6A0E@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608060300_MC3-1-C736-6A0E@compuserve.com>
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Chuck Ebbert on Sunday, 06 August, 2006:
>In-Reply-To: <20060806041700.GA5157@digitasaru.net>
>On Sat, 5 Aug 2006 23:17:01 -0500, Joseph Pingenot wrote:
>> I've now seen two boxes with 2.6.17.7 go down with IO errors after some
>>   time running.  There doesn't seem to necessarily be a fixed amount of
>>   time, nor can I precisely figure out what's causing it.
>How do you know they were IO errors?

That's what everything was saying, like when I tried to run any program.
Eventually, things that were running stayed running (e.g. I have irssi
  on one box showing symptoms and can still chat, but opening up a 
  new window in screen fails:

Could not write /var/run/utmp: No such process                                  
cannot exec '/bin/bash': Input/output error                                     

On reboot everything was fixed.  And the SMART diagnostic on a drive:
# 1  Extended offline    Completed without error       00%     12221 -

Some relevant SMART data:
5 Reallocated_Sector_Ct   0x0033   100   100   050    Pre-fail  Always -       0
1 Raw_Read_Error_Rate     0x000b   100   100   050    Pre-fail Always       -       0
196 Reallocated_Event_Count 0x0032   100   100   000    Old_age Always       -       0
198 Offline_Uncorrectable   0x0030   100   100   000    Old_age Offline      -       0
199 UDMA_CRC_Error_Count    0x0032   200   200   000    Old_age   Always -       0

I'll send the .config from the other downed box when I can get to it
  to reboot it.

>Did previous versions of 2.6.17 work?

It seemed to, but I'm far from certain.

>Please try to get debug output with netconsole if you can.

That will be very tough atm.  I'll see what I can do, though.
