Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310428AbSCLGFw>; Tue, 12 Mar 2002 01:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310429AbSCLGFp>; Tue, 12 Mar 2002 01:05:45 -0500
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:38604 "EHLO
	avocet.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S310428AbSCLGF1>; Tue, 12 Mar 2002 01:05:27 -0500
Message-ID: <01d101c1c98b$e5932f30$1125a8c0@wednesday>
From: "J. Dow" <jdow@earthlink.net>
To: "Linus Torvalds" <torvalds@transmeta.com>,
        "Jeff Garzik" <jgarzik@mandrakesoft.com>
Cc: "LKML" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0203111916000.18604-100000@penguin.transmeta.com>
Subject: Re: [patch] My AMD IDE driver, v2.7
Date: Mon, 11 Mar 2002 22:05:22 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Linus Torvalds" <torvalds@transmeta.com>

> > 3) There should be capability to optionally install filter the raw 
> > device command interface.  The filter is built into the kernel at 
> > compile-time, but can also be disabled at boot time.
> 
> This is the part I really don't like.
> 
> Thinking like a sysadmin, I want to be able to run programs that I would 
> not allow my users to run or want to be run accidentally. And I do _not_ 
> want to reboot my kernel just because one of my mirrored disks died, I 
> hot-replaced it, and I notice that I need to upgrade the firmware on the 
> thing to make it play nice with the other disks in the array.
> 
> See? A setup that either allows everything or nothing is fundamentally
> flawed in this kind of situation - suddenly I as a sysadmin cannot do
> something without bringing the machine down. Which makes all the hotplug
> interfaces useless - or then I as a sysadmin just have to leave a kernel 
> in place that allows the kinds of raw command accesses that I am so scared 
> of.

Good example. (I even implemented something of that sort for downloading
new firmware for Maxtor SCSI drives back when the 1G Panther was a brandy
spanky new thing. I never distributed it and have no plans of doing so.
Amigans as a rule are not good candidates for having such code on hand. The
average Linux SysAdmin should be a few dB smarter and more careful. I don't
think it would be a good thing to force multiple reboots in the situation
you cite. And it does happen.)

{^_^}    Joanne Dow

