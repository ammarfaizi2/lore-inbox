Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262819AbVGNALn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262819AbVGNALn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 20:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVGNAJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 20:09:40 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:48587 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S262779AbVGNAHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 20:07:44 -0400
Message-ID: <42D5ACCE.30504@vc.cvut.cz>
Date: Thu, 14 Jul 2005 02:07:42 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: dean gaudet <dean-list-linux-kernel@arctic.org>
CC: Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, "Brown, Len" <len.brown@intel.com>,
       dtor_core@ameritech.net, torvalds@osdl.org, vojtech@suse.cz,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
References: <42D3E852.5060704@mvista.com> <20050712162740.GA8938@ucw.cz> <42D540C2.9060201@tmr.com> <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz> <20050713184227.GB2072@ucw.cz> <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org> <1121282025.4435.70.camel@mindpipe> <d120d50005071312322b5d4bff@mail.gmail.com> <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org> <20050713211650.GA12127@taniwha.stupidest.org> <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org>
In-Reply-To: <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet wrote:
> On Wed, 13 Jul 2005, Chris Wedgwood wrote:
> 
> 
>>On Wed, Jul 13, 2005 at 01:48:57PM -0700, Andrew Morton wrote:
>>
>>>"My expectation is if we want to beat the competition, we'll want
>>>the ability to go *under* 100Hz."
>>
>>What does Windows do here?
> 
> 
> windows xp base rate is 100Hz... but multimedia apps can ask for almost 

83Hz

> any rate they want (depends on the hw capabilities).  i recall seeing 
> rates >1200Hz when you launch some of the media player apps -- sorry i 
> forget the exact number.

When you have (exactly one) VMware's VM with WindowsXP running on the box,
you can track guest's tick frequency changes in `dmesg` as vmmon reports
frequency guest wants while reprogramming /dev/rtc.

Highest frequency I ever saw is 2.6 Linux with local APIC - it needs 2kHz, as
1kHz timer from 8253 and from local APIC are shifted appart by exactly half
of their period.
							Petr Vandrovec

