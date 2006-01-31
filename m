Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbWAaVVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWAaVVH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 16:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWAaVVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 16:21:07 -0500
Received: from amdext3.amd.com ([139.95.251.6]:53934 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S1751498AbWAaVVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 16:21:04 -0500
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
Date: Tue, 31 Jan 2006 14:22:49 -0700
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: "Jens Axboe" <axboe@suse.de>
cc: linux-kernel@vger.kernel.org, rpurdie@rpsys.net
Subject: Re: LED: Add IDE disk activity LED trigger
Message-ID: <20060131212249.GR31163@cosmic.amd.com>
References: <20060131203552.GG4215@suse.de>
MIME-Version: 1.0
In-Reply-To: <20060131203552.GG4215@suse.de>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6FC10B211HW3887969-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/06 21:35 +0100, "Jens Axboe" wrote:
> Perhaps a generic solution isn't feasible, because this isn't really a
> generic problem. The LED stuff has very limited use - you mention
> embedded platforms, perhaps they should just be doing this on their own?

Possibly, but what you'll find is that many different embedded platforms
end up wanting similar behavior, and if they all do it on their own, that
ends up in a mess.

Take the Alchemy platform for example - we have a bank of LEDs at our
disposal, and we too would like to use them to do very similar things
as the ARM/Xscale folks - things like show IDE/SD/MTD traffic, or the 
status of a battery.   Rather then go in and hack that stuff in ourselves, 
I would much rather just define a few API hooks and getting the rest for 
free (or really cheap).

Perhaps it can be hidden behind a CONFIG_EMBEDDED or something so that
the desktop platforms aren't bothered by it, but speaking for the two 
embedded platforms I'm attached to, my vote for this LED class is a "yes".

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

