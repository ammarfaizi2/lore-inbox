Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262446AbULCRtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbULCRtq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 12:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbULCRtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 12:49:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16269 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262446AbULCRsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 12:48:13 -0500
Date: Fri, 3 Dec 2004 17:47:49 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dm-devel@redhat.com
Subject: Re: Suspend 2 merge: 50/51: Device mapper support.
Message-ID: <20041203174749.GF24233@agk.surrey.redhat.com>
Mail-Followup-To: Nigel Cunningham <ncunningham@linuxmail.org>,
	Pavel Machek <pavel@ucw.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	dm-devel@redhat.com
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101300802.5805.398.camel@desktop.cunninghams> <20041125235829.GJ2909@elf.ucw.cz> <1101427667.27250.175.camel@desktop.cunninghams> <20041202204042.GD24233@agk.surrey.redhat.com> <1102021461.13302.40.camel@desktop.cunninghams> <20041202214932.GE24233@agk.surrey.redhat.com> <1102025297.13302.51.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102025297.13302.51.camel@desktop.cunninghams>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2004 at 09:08:18AM +1100, Nigel Cunningham wrote:
> My mistake. The code has been improved and I haven't reverted some of
> the changes in drivers/md to match. I'll do that and make the two
> exports that are needed (dm_io_get and dm_io_put) into an
> include/linux/dm.h.
 
It would be device-mapper.h - or the whole of dm-io.h.
The vmalloc comment also looks wrong BTW - it's extra kmalloc 
GFP_KERNEL memory you're asking for here.

I'd like to understand why you need to call those functions
and how it integrates with the rest of what you're doing:
do you have calls to other dm functions in other patches?

Or is this particular change optional, but you have test results 
showing it to be desirable or necessary in certain cases, maybe 
indicating a shortcoming within the dm-io code which should be 
addressed instead?

Alasdair
-- 
agk@redhat.com
