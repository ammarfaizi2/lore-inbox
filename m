Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272921AbRIHAYu>; Fri, 7 Sep 2001 20:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272922AbRIHAYl>; Fri, 7 Sep 2001 20:24:41 -0400
Received: from f79.law10.hotmail.com ([64.4.15.79]:46347 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S272921AbRIHAY3>;
	Fri, 7 Sep 2001 20:24:29 -0400
X-Originating-IP: [194.65.14.70]
From: "Mack Stevenson" <mackstevenson@hotmail.com>
To: adilger@turbolabs.com
Cc: linux-kernel@vger.kernel.org, reiser@namesys.com,
        nerijus@users.sourceforge.net
Subject: Re: Basic reiserfs question
Date: Sat, 08 Sep 2001 02:24:43 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F79TdzI1J9Ofj8BrbOw0000a090@hotmail.com>
X-OriginalArrivalTime: 08 Sep 2001 00:24:43.0420 (UTC) FILETIME=[A8132DC0:01C137FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andreas,

>From: Andreas Dilger <adilger@turbolabs.com>
>To: Mack Stevenson <mackstevenson@hotmail.com>
>CC: linux-kernel@vger.kernel.org, reiser@namesys.com,   
>nerijus@users.sourceforge.net
>Subject: Re: Basic reiserfs question
>Date: Fri, 7 Sep 2001 11:04:26 -0600
>
>On Sep 07, 2001  13:38 +0200, Mack Stevenson wrote:
> > >From syslog, referring to the last time I booted my machine:
> >
> > reiserfs: checking transaction log (device 03:02) ...
> > Warning, log replay starting on readonly filesystem
> > reiserfs: replayed 16 transactions in 4 seconds
> > using r5 hash to sort names
> > ReiserFS version 3.6.25
> > VFS: Mounted root (reiserfs filesystem) readonly.
>
>This clearly means that it is a "dirty" shutdown, because it is replaying
>the journal log.

Right.

> > Should I worry if I don't get such messages whenever I boot? Or should I
> > worry if I get those messages after (apparently) clean shutdown 
>procedures?
>
>It would be troublesome if you got the messages after a clean shutdown.

That's what happening (kernel 2.4.8), about 1 out of 5 times .

>This might mean that reiserfs is not syncing some journal buffers to disk
>when the root filesystem is remounted read-only.  Alternately, it may mean
>that it is finding bogus transactions to replay in the journal (I don't
>know how reiserfs determines whether the journal is clean or dirty).
>
>It may also mean that your disk claims to have written data to disk, but
>then only puts it in cache and you power off before in actually writes it.
>Do you have APM/ACPI power off after shutdown?

Yes, I run APM. Should I try disabling APM power off and manually doing so 
instead?

Thank you,

Mack


_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

