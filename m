Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751648AbWF1WwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbWF1WwQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 18:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbWF1WwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 18:52:16 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:28121 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751643AbWF1WwP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 18:52:15 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Sebastian =?utf-8?q?K=C3=BCgler?= <sebas@kde.org>
Subject: Re: swsusp / suspend2 reliability (was Re: [Suspend2-devel] Re: Suspend2 - Request for review & inclusion =?utf-8?q?in=09-mm?=)
Date: Thu, 29 Jun 2006 00:52:36 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@ucw.cz>, suspend2-devel@lists.suspend2.net,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
References: <200606270147.16501.ncunningham@linuxmail.org> <20060628195316.GB18039@elf.ucw.cz> <200606290019.17298.sebas@kde.org>
In-Reply-To: <200606290019.17298.sebas@kde.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200606290052.36243.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 29 June 2006 00:19, Sebastian Kügler wrote:
> On Wednesday 28 June 2006 21:53, Pavel Machek wrote:
> > Okay, can I get some details? Like how much memory does system have,
> > what stress test causes the failure?
> 
> The machine has 1GB of RAM, filling it up beyond 500MB, maybe 600MB usually 
> made swsusp a problem. I'd need to close apps then to be able to suspend.

That sounds strange to me as I have never had any problems of this kind with
swsusp and I sometimes have RAM almost 100% full before suspend
(there's 1.5 GB on my box).

First, have you tried setting the size of the image using /sys/power/image_size?

Second, the swsusp's memory shrinker has been reworked recently and the
patch should be in the latest git.  Could you please check if the problems persist
with the newest -git kernels?

Greetings,
Rafael
