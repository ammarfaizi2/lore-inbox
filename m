Return-Path: <linux-kernel-owner+w=401wt.eu-S932626AbXAHIWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbXAHIWA (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 03:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbXAHIWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 03:22:00 -0500
Received: from mx0.vr-web.de ([195.200.35.198]:47556 "EHLO mx0.vr-web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932626AbXAHIV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 03:21:59 -0500
From: Andreas Hartmann <andihartmann@01019freenet.de>
X-Newsgroups: linux.kernel
Subject: Re: [2.6.18.2] ide_core bug: kobject_add failed for ide ... - with
 vanilla kernel
Date: Mon, 08 Jan 2007 09:21:29 +0100
Organization: privat
Message-ID: <ensuu8$4l8$1@p54A1BFDA.dip0.t-ipconnect.de>
References: <7AKD9-50K-21@gated-at.bofh.it> <7ALze-6sT-19@gated-at.bofh.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-Complaints-To: abuse@arcor.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.8.1.1) Gecko/20070105 SeaMonkey/1.1
In-Reply-To: <7ALze-6sT-19@gated-at.bofh.it>
X-Enigmail-Version: 0.94.1.2.0
To: linux-kernel@vger.kernel.org
X-BitDefender-Scanner: Clean, Agent: BitDefender Courier MTA Agent
 1.6.2 on vrwebmail
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lee,

Lee Revell wrote:
> On Sun, 2007-01-07 at 18:44 +0100, Andreas Hartmann wrote:
>> Hello,
>> 
>> ide_core is loaded (while putting in an USB stick) as module the first
>> time after reboot - all works fine. The USB stick got mounted and a ls
>> is done to show the files on the root of the filesystem of the stick.
>> Afterwards, the stick is securely removed from the system.
>> Afterwards, ide_core is unloaded with rmmod (after usb-storage has been
>> unloaded) - ok.
>> 
>> Next step is to load ide_core again. Now, the following error can be
>> found in /var/log/messages:
>> 
>> 
>> Jan  7 11:48:18 notebook1 kernel: Uniform Multi-Platform E-IDE driver
>> Revision: 7.00alpha2
>> Jan  7 11:48:18 notebook1 kernel: ide: Assuming 33MHz system bus speed
>> for PIO modes; override with idebus=xx
>> Jan  7 11:48:18 notebook1 kernel: kobject_add failed for ide with
>> -EEXIST, don't try to register things with the same name in the same
>> directory.
> 
> You seem to be running a SuSE kernel - please report the issue to them.

You are right - but the same error appears with the vanilla kernel, too.
That's why I reported it here.

> It's probably useful to repeat your test but run "find /sys/module >
> sys1" before loading ide_core the first time, then "find /sys/module >
> sys2" after "rmmod ide_core", and save the output of "diff sys1 sys2".

There isn't any difference.


Kind regards,
Andreas Hartmann
