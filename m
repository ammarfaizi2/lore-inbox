Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWGKXLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWGKXLW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 19:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWGKXLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 19:11:21 -0400
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:51082 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751345AbWGKXLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 19:11:21 -0400
Message-ID: <44B43019.9010402@namesys.com>
Date: Tue, 11 Jul 2006 16:11:21 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Clay Barnes <clay.barnes@gmail.com>
CC: Reiserfs mail-list <Reiserfs-List@namesys.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>
Subject: Re: short term task list for Reiser4
References: <44B42064.4070802@namesys.com> <20060711222903.GG9220@HAL_5000D.tc.ph.cox.net>
In-Reply-To: <20060711222903.GG9220@HAL_5000D.tc.ph.cox.net>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clay Barnes wrote:

>On 15:04 Tue 11 Jul     , Hans Reiser wrote:
>  
>
>>
>>6) optimize fsync --- substantive task which requires using fixed area
>>for write twice logging, and using write twice logging for fsync'd
>>data.  It might require creating mount options to choose whether to
>>optimize for serialized sequential fsyncs vs. lazy fsyncs.
>>    
>>
>With the serialized sequential fsync, is that essentially what I was
>talking about earlier with slowly streaming dirty writes to disk when
>the HDD is idle?  If that's the case, I don't see the advantage in having
>lazy fsyncs
>
if you are optimizing throughput rather than latency, then you let
things get to disk whenever they get there, and you let the app hang
while it waits. A mailer processing many requests in parallel might find
30 seconds of latency to be just fine but a database might find 3
seconds of latency to be too much. (I make up these examples, mailer
programmers please correct me.)

> except in situations where you want to keep the HDD spun down
>as much as possible.
>
No, that is not when you do it.

>I've been meaning to hose my laptop (assuming I fix one problem with my
>desktop), so I am willing to help write Gentoo install docs (or possibly
>Arch Linux).  I can also test exsiting instructions.
>  
>
That would be way cool.
<http://wiki.namesys.com/Reiser4-GettingStarted#preview>

