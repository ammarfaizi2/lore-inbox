Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292385AbSCCFIA>; Sun, 3 Mar 2002 00:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293053AbSCCFHv>; Sun, 3 Mar 2002 00:07:51 -0500
Received: from mailout6-0.nyroc.rr.com ([24.92.226.125]:32925 "EHLO
	mailout6.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S292385AbSCCFHm>; Sun, 3 Mar 2002 00:07:42 -0500
Message-ID: <02bb01c1c271$7f717700$1a01a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: "Chris Wedgwood" <cw@f00f.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.inaf1vv.one4p5@ifi.uio.no> <fa.esfhmsv.bku814@ifi.uio.no>
Subject: Re: LFS Support for Sendfile
Date: Sun, 3 Mar 2002 00:08:45 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     [sendfile(2)] as defined does not support LFS.
>
> I wonder does it really need to?  I mean, a loop calling sendfile for
> 2GB (or whatever) at a time is almost as good, if not better in some
> ways.

The 'count' parameter is not the problem, it's the 'offset'. You can't send
any data beyond 2GB from the beginning of the file...

And in fact just two days ago I was in a situation where this would have
been desirable - I was sending parts of a captured DV video stream (the file
was 6GB)...

Regards,
Dan

