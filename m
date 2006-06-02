Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWFBKIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWFBKIa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 06:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWFBKIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 06:08:30 -0400
Received: from mailgw3.ericsson.se ([193.180.251.60]:13016 "EHLO
	mailgw3.ericsson.se") by vger.kernel.org with ESMTP
	id S1751209AbWFBKIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 06:08:30 -0400
Message-ID: <44800E1A.1080306@ericsson.com>
Date: Fri, 02 Jun 2006 12:08:26 +0200
From: Preben Traerup <Preben.Trarup@ericsson.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com>
CC: vgoyal@in.ibm.com, fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [RFC][PATCH] Add missing notifier before crashing
References: <20060530183359.a8d5d736.akiyama.nobuyuk@jp.fujitsu.com>	<20060530145658.GC6536@in.ibm.com>	<20060531182045.9db2fac9.akiyama.nobuyuk@jp.fujitsu.com>	<20060531154322.GA8475@in.ibm.com>	<20060601213730.dc9f1ec4.akiyama.nobuyuk@jp.fujitsu.com>	<20060601151605.GA7380@in.ibm.com> <20060602141301.cdecf0e1.akiyama.nobuyuk@jp.fujitsu.com>
In-Reply-To: <20060602141301.cdecf0e1.akiyama.nobuyuk@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jun 2006 10:08:28.0552 (UTC) FILETIME=[7E7E3080:01C6862C]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akiyama, Nobuyuki wrote:

>
>I don't think all people will use kdump(but I recommend my customer
>to use kdump ;-).
>The aim of panic notifier and crash notifier is a little different,
>so I thought these notifier lists should be separated.
>The panic notifier was not expected of kdump after notifier return!
>I think the better way is to modify panic notifiers to fit with
>kdump and to move into crash notifier gradually if necessary.
>
>  
>
Since I'm one of the people who very much would like best of both worlds,
I do belive Vivek Goyal's concern about the reliability of kdump must be
adressed properly.

I do belive the crash notifier should at least be a list of its own.
  Attaching element to the list proves your are kdump aware - in theory

However:

Conceptually I do not like the princip of implementing crash notifier
as a list simply because for all (our) practical usage there will only
be one element attached to the list anyway.

And as I belive crash notifiers only will be used by a very limited
number of users, I suggested in another mail that a simple

if (function pointer)
   call functon

approach to be used for this special case to keep things very simple.


./Preben





