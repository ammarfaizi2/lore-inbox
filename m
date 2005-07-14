Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVGNJ3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVGNJ3l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 05:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbVGNJ2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 05:28:16 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:65213 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261287AbVGNJZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 05:25:55 -0400
Date: Thu, 14 Jul 2005 11:24:48 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, "Brown, Len" <len.brown@intel.com>,
       dtor_core@ameritech.net, torvalds@osdl.org, vojtech@suse.cz,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <42D5ACCE.30504@vc.cvut.cz>
Message-ID: <Pine.LNX.4.61.0507141118580.18072@yvahk01.tjqt.qr>
References: <42D3E852.5060704@mvista.com> <20050712162740.GA8938@ucw.cz>
 <42D540C2.9060201@tmr.com> <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>
 <20050713184227.GB2072@ucw.cz> <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
 <1121282025.4435.70.camel@mindpipe> <d120d50005071312322b5d4bff@mail.gmail.com>
 <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
 <20050713211650.GA12127@taniwha.stupidest.org>
 <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org> <42D5ACCE.30504@vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> "My expectation is if we want to beat the competition, we'll want
>>>> the ability to go *under* 100Hz."
>>> 
>>> What does Windows do here?
>>
>> windows xp base rate is 100Hz... but multimedia apps can ask for almost 
>
> 83Hz

Well, Windoes 98 (vmmon) shows very different ones:

/dev/vmmon[4355]: host clock rate change request 0 -> 19
/dev/vmmon[4355]: host clock rate change request 19 -> 0
/dev/vmmon[4355]: host clock rate change request 0 -> 19
/dev/vmmon[4355]: host clock rate change request 19 -> 63
/dev/vmmon[4355]: host clock rate change request 63 -> 200
/dev/vmmon[4355]: host clock rate change request 200 -> 201
/dev/vmmon[4355]: host clock rate change request 201 -> 1001

>> any rate they want (depends on the hw capabilities).  i recall seeing
>> rates >1200Hz when you launch some of the media player apps -- sorry i
>> forget the exact number.

I have seen some apps which seem to schedule themselves using some kind of
SCHED_FIFO and therefore seem to get good RT:

from an ini file...
  # This option determines the multi-tasking capabilities of WinDEU.
  # The priority determines the minimum number of milliseconds WinDEU
  # will work before giving control back to Windows.
  # For example, if you set it to 20, it means WinDEU will gives
  # back control to Windows approximately (at most) 50 times a second.
  # A value of 0 means WinDEU WON'T multi-task.
  # (Can be changed in the preferences dialog box.)
  BuildPriority=25



Jan Engelhardt
-- 
