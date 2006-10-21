Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422775AbWJUSgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422775AbWJUSgP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 14:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422691AbWJUSgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 14:36:15 -0400
Received: from main.gmane.org ([80.91.229.2]:40641 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1422775AbWJUSgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 14:36:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Jellinghaus <aj@ciphirelabs.com>
Subject: Re: Ordering hotplug scripts vs. udev device node creation
Date: Sat, 21 Oct 2006 20:36:00 +0200
Message-ID: <453A6890.5030803@ciphirelabs.com>
References: <727e50150610211021s7779b787s7bac8f409a3f2518@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ciphirelabs.net
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
In-Reply-To: <727e50150610211021s7779b787s7bac8f409a3f2518@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

not sure, I ran into the same problem with usb device files
(both in /proc and /dev/bus/usb). and my quick hack was to simply
add a "sleep 1".

but there might be a cleaner solution:
with udevmonitor you should see what udev does, and it should
give you the name of the device it creates, so the call to udevinfo
should not be needed. and when that event with the device name
comes in - at least I hope - udev has already created it.

(at least I think it would be right if it creates a file to fire
the event associated with doing that after the mknod.)

maybe give it a try. reporting back here (or on the hotplug mailing
list which might be more appropriate) would be very welcome, as you
are not the only one running into these kind of problems.

good luck!

Andreas

