Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272530AbTGZOoc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272497AbTGZOnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:43:07 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:48365 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S272530AbTGZOlD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:41:03 -0400
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
From: Yury Umanets <umka@namesys.com>
To: Daniel Egger <degger@fhm.edu>
Cc: Nikita Danilov <Nikita@Namesys.COM>, Hans Reiser <reiser@namesys.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       reiserfs mailing list <reiserfs-list@namesys.com>
In-Reply-To: <1059228808.10692.7.camel@sonja>
References: <3F1EF7DB.2010805@namesys.com>
	 <1059062380.29238.260.camel@sonja>
	 <16160.4704.102110.352311@laputa.namesys.com>
	 <1059093594.29239.314.camel@sonja>
	 <16161.10863.793737.229170@laputa.namesys.com>
	 <1059142851.6962.18.camel@sonja>
	 <1059143985.19594.3.camel@haron.namesys.com>
	 <1059181687.10059.5.camel@sonja>
	 <1059203990.21910.13.camel@haron.namesys.com>
	 <1059228808.10692.7.camel@sonja>
Content-Type: text/plain
Organization: NAMESYS
Message-Id: <1059231274.28094.40.camel@haron.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3.99 
Date: Sat, 26 Jul 2003 18:54:34 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-07-26 at 18:13, Daniel Egger wrote:
> Am Sam, 2003-07-26 um 09.19 schrieb Yury Umanets:
> 
> > I think this is more then enough for running reiser4. Reiser4 is a linux
> > filesystem first of all, and linux is able to be ran on even worse
> > hardware then you have.
> 

> Linux is running just fine one the system, thanks. My question is
> whether reiserfs is suitable for flash devices. The chances to get some
> usable answers seem to be incredible low though...

Reiserfs cannot be used efficiently with flash, as it uses block size 4K
(by default) and usual flash block size is in range 64K - 256K.

Also reiserfs does not use compression, that would be very nice of it
:), because flash has limited number of erase cycles per block (in range
100.000) and it is about three times as expensive as SDRAM.

So, it is better to use something more convenient. For instance jffs2.

But, if you are still want to use reiserfs for flash device, you should
do at least the following: 

(1) Make the journal substantial smaller of size.
(2) Don't turn tails off. This is useful to prolong flash live.


Regards.

-- 
We're flying high, we're watching the world passes by...

