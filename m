Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752360AbWKBVWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbWKBVWV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 16:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752334AbWKBVWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 16:22:21 -0500
Received: from mga01.intel.com ([192.55.52.88]:26429 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1752027AbWKBVWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 16:22:20 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,381,1157353200"; 
   d="scan'208"; a="156819461:sNHT18121026"
Message-ID: <454A6180.9090501@intel.com>
Date: Thu, 02 Nov 2006 13:22:08 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Jesse Brandeburg <jesse.brandeburg@intel.com>,
       Adrian Bunk <bunk@stusta.de>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Laurent Riffard <laurent.riffard@free.fr>,
       Rajesh Shah <rajesh.shah@intel.com>, toralf.foerster@gmx.de,
       Jeff Garzik <jeff@garzik.org>, Pavel Machek <pavel@ucw.cz>,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.19-rc4: known unfixed regressions
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>	<20061031195654.GV27968@stusta.de>	<200611022102.02302.rjw@sisk.pl> <20061102121027.676db964.akpm@osdl.org>
In-Reply-To: <20061102121027.676db964.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 2 Nov 2006 21:02:01 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
>> Hi,
>>
>> On Tuesday, 31 October 2006 20:56, you wrote:
>>> This email lists some known regressions in 2.6.19-rc4 compared to 2.6.18
>>> that are not yet fixed in Linus' tree.
>> Can we please add the following two to the list of known regressions:
> 
> Balls are being dropped.
> 
>> http://bugzilla.kernel.org/show_bug.cgi?id=7082
> 
> So this was a good patch but because of a bug in ne2k-pci which nobody is
> fixing we need to drop it?
> 
>> http://bugzilla.kernel.org/show_bug.cgi?id=7207
> 
> Auke, Jesse - can you please opine on this?

I have been looking at this already but not identified the real issue. There are other 
things wrong with suspend/resume and the adapter stats are garbled too after resume 
(ethtool -s ethX shows). This appeared in 2.6.18 somehow

I'll make it high priority and carve into old revisions asap.

Auke
