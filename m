Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262452AbSLYIdA>; Wed, 25 Dec 2002 03:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263991AbSLYIdA>; Wed, 25 Dec 2002 03:33:00 -0500
Received: from packet.digeo.com ([12.110.80.53]:929 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262452AbSLYIc7>;
	Wed, 25 Dec 2002 03:32:59 -0500
Message-ID: <3E096F21.DBD6BEF5@digeo.com>
Date: Wed, 25 Dec 2002 00:41:05 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: Poor performance with 2.5.52, load and process in D state
References: <20021222113754.15064.qmail@linuxmail.org> <3E06F399.655E0005@digeo.com> <200212250824.gBP8Nus17429@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Dec 2002 08:41:06.0354 (UTC) FILETIME=[5D7A0120:01C2ABF1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> 
> ...
> I wonder whether swappiness should be related to the speed
> ratio between storage types? How exactly?

It doesn't matter.  Assuming the latency of the swap device is the
same as the filesystem device it cancels out.  We're simply trying
to minimise the total amount of I/O.
 
> Having to play with tunables is not an ideal way to go,
> I hate to think that Andrew's (and others) work can go down
> the drain at the very next technology jump.

It's constant-access-time mass storage technology which will toss 20
years development down the gurgler.  Top to bottom, everything is
designed to support the locality=bandwidth characteristics of spinning
disks.
