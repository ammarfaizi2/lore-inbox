Return-Path: <linux-kernel-owner+w=401wt.eu-S1751620AbXAUVFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbXAUVFQ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 16:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbXAUVFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 16:05:16 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:34900 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620AbXAUVFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 16:05:14 -0500
Date: Sun, 21 Jan 2007 22:04:24 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Pavel Machek <pavel@ucw.cz>
cc: Alessandro Di Marco <dmr@gmx.it>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] System Inactivity Monitor v1.0
In-Reply-To: <20070119101103.GA5730@ucw.cz>
Message-ID: <Pine.LNX.4.61.0701212201220.29213@yvahk01.tjqt.qr>
References: <877ivkrv5s.fsf@gmx.it> <20070119101103.GA5730@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 19 2007 10:11, Pavel Machek wrote:
>
>> this is a new 2.6.20 module implementing a user inactivity trigger. Basically
>> it acts as an event sniffer, issuing an ACPI event when no user activity is
>> detected for more than a certain amount of time. This event can be successively
>> grabbed and managed by an user-level daemon such as acpid, blanking the screen,
>> dimming the lcd-panel light ? la mac, etc...
>
>While functionality is extremely interesting.... does it really have
>to be in kernel?

I think so. While the X server grabs off any keyboard and mouse activity
on its own, there is no such thing for the [read "all"] console[s].
Mouse movement (e.g. GPM) is actually implemented in the kernel,
and screen blanking (the one controlled with "\e[9;x]") is too.


	-`J'
-- 
