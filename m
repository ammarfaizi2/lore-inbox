Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264911AbUE0Rl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264911AbUE0Rl4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 13:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264834AbUE0Rla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 13:41:30 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:65199 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S264902AbUE0Rl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 13:41:26 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: [patch 2.6] don't put IDE disks in standby mode on halt on
	Alpha
Date: Thu, 27 May 2004 17:41:25 +0000 (UTC)
Organization: Cistron Group
Message-ID: <c95985$gd7$1@news.cistron.nl>
References: <20040527194920.A1709@jurassic.park.msu.ru> <1085675193.7179.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1085679685 16807 62.216.29.200 (27 May 2004 17:41:25 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1085675193.7179.5.camel@laptop.fenrus.com>,
Arjan van de Ven  <arjanv@redhat.com> wrote:
>On Thu, 2004-05-27 at 17:49, Ivan Kokshaysky wrote:
>> Spinning the disks down across a 'halt' on Alpha is even
>> worse than doing that on reboot on i386 (assuming the
>> boot device is IDE disk).
>
>how do you flush the disks' writecache then? Halting the disk seems to
>be the only reliable way to do so.

On Alpha, Sun and other hardware, "halt" puts you into the firmware
monitor. It doesn't actually turn the machine off, so it's not
critical to flush the write cache of the disk - the only time
that is really neccesary is right before poweroff, in all other
cases the disk will expire the write cache itself.

Mike.

