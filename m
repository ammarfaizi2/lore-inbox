Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269332AbRGaPyv>; Tue, 31 Jul 2001 11:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269331AbRGaPyl>; Tue, 31 Jul 2001 11:54:41 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:42766 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S269330AbRGaPya>; Tue, 31 Jul 2001 11:54:30 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: Support for serial console on legacy free machines
Date: Tue, 31 Jul 2001 15:54:38 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9k6kbu$suo$4@ncc1701.cistron.net>
In-Reply-To: <200107302332.f6UNWbxg001791@webber.adilger.int> <3B65F1A2.30708CC1@fc.hp.com> <000701c119cd$ebf0c720$294b82ce@connecttech.com>
X-Trace: ncc1701.cistron.net 996594878 29656 195.64.65.67 (31 Jul 2001 15:54:38 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In article <000701c119cd$ebf0c720$294b82ce@connecttech.com>,
Stuart MacDonald <stuartm@connecttech.com> wrote:
>C) serial.c contains a completely separate serial console driver,
>complete with its own init routine. Which meshes with the current
>suggestion that the "serial driver" isn't used, and pci init happens
>too late.

That's because you expect printk() to work even if interrupts
don't (yet), so there's a mini driver in there that works in polled
mode and is completely anatomous (sp?).

Also, the `real' serial driver only works when /dev/ttySx is opened by
a process - it needs a lot of context (file handles etc) that is
dependent on stuff that is only available after the system has booted.

Mike.
-- 
"dselect has a user interface which scares small children"
	-- Theodore Tso, on debian-devel

