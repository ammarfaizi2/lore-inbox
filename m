Return-Path: <linux-kernel-owner+w=401wt.eu-S1425539AbWLHPJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425539AbWLHPJZ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 10:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425544AbWLHPJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 10:09:25 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:49309 "EHLO
	hp3.statik.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425539AbWLHPJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 10:09:24 -0500
Message-ID: <45798022.2090104@s5r6.in-berlin.de>
Date: Fri, 08 Dec 2006 16:09:22 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net
CC: Pavel Machek <pavel@ucw.cz>, Erik Mouw <erik@harddisk-recovery.com>,
       Kristian H?gsberg <krh@redhat.com>,
       Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] New firewire stack
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com> <1165308400.2756.2.camel@localhost> <45758CB3.80701@redhat.com> <20061205160530.GB6043@harddisk-recovery.com> <20060712145650.GA4403@ucw.cz>
In-Reply-To: <20060712145650.GA4403@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote at linux-kernel:
> On Tue 05-12-06 17:05:30, Erik Mouw wrote:
>> On Tue, Dec 05, 2006 at 10:13:55AM -0500, Kristian H?gsberg wrote:
>> > Marcel Holtmann wrote:
>> > >can you please use drivers/firewire/ if you want to start clean or
>> > >aiming at replacing drivers/ieee1394/. Using "fw" as an abbreviation in
>> > >the directory path is not really helpful.
>> > 
>> > Yes, that's probably a better idea.  Do you see a problem with using fw_* 
>> > as a prefix in the code though?  I don't see anybody using that prefix, but 
>> > Stefan pointed out to me that it's often used to abbreviate firmware too.
>> 
>> So what about fiwi_*? If that's too close to wifi_*, try frwr_.
> 
> Ugly, but fwire could be acceptable.

How about this:
Let's let Kristian continue to work with his chosen fw_ prefix until his
drivers are ready to be pulled in (into the linux1394 repo and -mm),
then make a decision about prefixes. It's mostly a matter of running sed
over the files.

One thing is for sure, the fw_ prefix is not too well suited to stay
if/when Kristian's code is pushed to mainline. During a switch period,
we could e.g. replace the old stack's prefixes by hpsb1_ (as the 1st
generation of FireWire kernel APIs) or whatever and replace Kristian's
prefixes by hpsb_. I would actually like fw_ most (if it wasn't so
overloaded and already used in other contexts) and the author's decision
should be honored too.

Regarding the directory name, I favor to stick everything into
drivers/ieee1394 even if it could get crowded during a transition period.
-- 
Stefan Richter
-=====-=-==- ==-- -=---
http://arcgraph.de/sr/
