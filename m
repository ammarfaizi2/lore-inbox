Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWCGVQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWCGVQL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 16:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWCGVQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 16:16:11 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:10371 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S932284AbWCGVQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 16:16:10 -0500
Message-ID: <440DF802.8@tlinx.org>
Date: Tue, 07 Mar 2006 13:15:46 -0800
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Marr <marr@flex.com>
CC: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, Andrew Morton <akpm@osdl.org>
Subject: Re: Readahead value 128K? (was Re: Drastic Slowdown of 'fseek()'
 Calls From 2.4 to 2.6 -- VMM Change?)
References: <200602241522.48725.marr@flex.com> <4403935A.3080503@tmr.com> <440B6E05.9010609@tlinx.org> <200603071453.46768.marr@flex.com>
In-Reply-To: <200603071453.46768.marr@flex.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marr wrote:
> On Sunday 05 March 2006 6:02pm, Linda Walsh wrote:
>> Does this happen with a seek call as well, or is this limited
>> to fseek?
>>
>> if you look at "hdparm's" idea of read-ahead, what does it say
>> for the device?.  I.e.:
>>
>> hdparm /dev/hda:
>>
>> There is a line entitled "readahead".  What does it say?
>
> Linda,
>
> I don't know (based on your email addressing) if you were directing this 
> question at me, but since I'm the guy who originally reported this issue, 
> here are my 'hdparm' results on my (standard Slackware 10.2) ReiserFS 
> filesystem:
>
>    2.6.13 (with 'nolargeio=1' for reiserfs mount): 
>       readahead    = 256 (on)
>
>    2.6.13 (without 'nolargeio=1' for reiserfs mount): 
>       readahead    = 256 (on)
>
>    2.4.31 ('nolargeio' option irrelevant/unavailable for 2.4.x): 
>       readahead    = 8 (on)
>
> *** Please CC: me on replies -- I'm not subscribed.
>
> Regards,
> Bill Marr
--------
    Could you retry your test with read-ahead set to a smaller
value?  Say the same as in 2.4 (8) or 16 and see if that changes
anything?

hdparm -a8 /dev/hdx
  or
hdparm -a16 /dev/hdx



