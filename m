Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTK2UTa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 15:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbTK2UTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 15:19:30 -0500
Received: from cs2417481-26.houston.rr.com ([24.174.81.26]:32137 "EHLO
	dmdtech.org") by vger.kernel.org with ESMTP id S262714AbTK2UT2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 15:19:28 -0500
Message-ID: <012301c3b6b6$2feb9fe0$1e01a8c0@dmdtech2>
From: "Darren Dupre" <darren@dmdtech.org>
To: "Adam Kropelin" <akropel1@rochester.rr.com>
Cc: <linux-kernel@vger.kernel.org>
References: <009201c3b6a6$f8e7e800$1e01a8c0@dmdtech2> <20031129163806.A14451@mail.kroptech.com>
Subject: Re: "DV failed to configure device" for Quantum DLT4000 tape drive on Adaptec 2940UW, 2.6.0-test11
Date: Sat, 29 Nov 2003 14:20:09 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm. That does reflect exactly what happened in my situation. I turned on
the tape drive, inserted a tape, and while it was busy rewinding, I inserted
the aic7xxx module.

I just tried inserting the module again, this time with no tape in the drive
as I turned it on and it initializes just fine and loads the st module. It
works fine doing everything else AFAIK.

But it still complains when I unload the modules..

Adam Kropelin <akropel1@rochester.rr.com>
>
> I've seen this same issue with my Quantum DLT4000 & 2940UW as well. It
> seems to have to do with there being a tape in the drive when the
> aic7xxx driver initializes. It looks to me like the DLT4000 does not
> respond to the DV configuration attempt when it is in the middle of
> rewinding a tape. If the rewind takes long enough, aic7xxx times out the
> configuration and gives the message you saw.
>
> I run a completely static kernel so in my case the problem happens when
> I reboot the machine with a tape still in the drive and the tape is
> positioned near the end. When the 2940UW BIOS initializes it triggers
> the DLT4000 to start rewinding the tape and if the tape is positioned
> far enough along it can still be rewinding when the kernel boots and
> aic7xxx tries to perform the DV configuration.
>
> --Adam
>
>

