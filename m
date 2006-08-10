Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161191AbWHJMAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161191AbWHJMAy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 08:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161193AbWHJMAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 08:00:54 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:55498 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1161191AbWHJMAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 08:00:53 -0400
Message-ID: <44DB1F19.8000504@s5r6.in-berlin.de>
Date: Thu, 10 Aug 2006 13:57:13 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Chuck Ebbert <76306.1226@compuserve.com>, Pavel Machek <pavel@suse.cz>,
       Josh Boyer <jwboyer@gmail.com>, Greg KH <greg@kroah.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Adrian Bunk is now taking over the 2.6.16-stable branch
References: <200608091749_MC3-1-C796-5E8D@compuserve.com> <20060809220048.GE3691@stusta.de>
In-Reply-To: <20060809220048.GE3691@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
...
> I'm currently 
> going through all 2.6.17.7 and 2.6.17.8 patches looking for patches I 
> should apply.

Suggested updates for drivers/ieee1394/:

(from 2.6.17.2)
  Fix broken suspend/resume in ohci1394
should be applicable as-is. This does not add full suspend/resume
functionality to ohci1394 but it fixes fatal side effects on other
on-board hardware after resume.

(from 2.6.17.8)
  ieee1394: sbp2: enable auto spin-up for Maxtor disks
doesn't apply to 2.6.16 as-is.
https://bugzilla.novell.com/show_bug.cgi?id=183011#c6 has an adapted
version. I will mail it to you with proper description and signed-off-by
later today. While I am at it, I will resend that ohci1394 patch too.

I have a related question about your plans with Linux 2.6.16.yy.
Documentation/stable_kernel_rules.txt says:

 - It must fix a problem that causes a build error (but not for things
   marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
   security issue, or some "oh, that's not good" issue.  In short,
   something critical.

I plan to submit a patch of the kind "fix recognition of a quirky
device" for 2.6.18. That patch does not fix an oops, hang, data
corruption, or security hole. (The patch will fulfill all other criteria
from stable_kernel_rules.) Do you consider "can't use that shiny device
under Linux" as "oh, that's not good" in the context of Linux 2.6.16.yy?

(I will not submit that patch for 2.6.17.y. I suppose I also wouldn't
submit it for 2.6.18.1 if it came too late for 2.8.18. One reason for me
to hesitate is because people who are able to patch their kernel can
already get fully up-to-date ieee1394 drivers from me for kernels as old
as 2.6.14.)
-- 
Stefan Richter
-=====-=-==- =--- -=-=-
http://arcgraph.de/sr/
