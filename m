Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262693AbVDAKdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbVDAKdo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 05:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbVDAKdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 05:33:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:13282 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262693AbVDAKdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 05:33:40 -0500
Message-ID: <424D2361.5000602@suse.de>
Date: Fri, 01 Apr 2005 12:33:05 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ncunningham@cyclades.com, Pavel Machek <pavel@suse.cz>,
       dtor_core@ameritech.net, Patrick Mochel <mochel@digitalimplant.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Andy Isaacson <adi@hexapodia.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Re: swsusp 'disk' fails in bk-current - intel_agp
 at fault?
References: <20050329181831.GB8125@elf.ucw.cz> <20050331221814.GC1802@elf.ucw.cz> <1112308137.18871.7.camel@desktop.cunningham.myip.net.au> <200504011049.01540.rjw@sisk.pl>
In-Reply-To: <200504011049.01540.rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> Hi,
>> On Fri, 2005-04-01 at 08:18, Pavel Machek wrote:
>> > I believe we should freeze hotplug before processes.
> 
> I agree.  IMO user space should not be considered as available once we have
> started freezing processes, so hotplug should be disabled before.  By the same
> token, it should only be enabled after the processes have been restarted
> during resume (or after suspend has failed).

it has probably to be enabled before the processes are restarted - they
may rightfully assume that hotplug is working.
-- 
seife
                                 Never trust a computer you can't lift.
