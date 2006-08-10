Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161349AbWHJOGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161349AbWHJOGf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 10:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161347AbWHJOGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 10:06:35 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:5090 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161296AbWHJOGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 10:06:34 -0400
Message-ID: <44DB3D65.6030308@garzik.org>
Date: Thu, 10 Aug 2006 10:06:29 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] sector_t format string
References: <1155172843.3161.81.camel@localhost.localdomain> <20060809234019.c8a730e3.akpm@osdl.org> <Pine.LNX.4.64.0608101302270.6762@scrub.home> <44DB203A.6050901@garzik.org> <Pine.LNX.4.64.0608101409350.6762@scrub.home> <44DB25C1.1020807@garzik.org> <Pine.LNX.4.64.0608101429510.6762@scrub.home> <44DB27A3.1040606@garzik.org> <Pine.LNX.4.64.0608101459260.6761@scrub.home> <44DB3151.8050904@garzik.org> <Pine.LNX.4.64.0608101519560.6762@scrub.home> <44DB34FF.4000303@garzik.org> <Pine.LNX.4.64.0608101547261.6761@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0608101547261.6761@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Thu, 10 Aug 2006, Jeff Garzik wrote:
> 
>> Roman Zippel wrote:
>>> If you force everyone to use 64bit sector numbers, I don't understand how
>>> you can claim "still working just fine on 32bit"?
>> 64bit sector numbers work just fine on 32-bit machines.
> 
> Depends on the definition of "fine".
> 
>>> At some point ext4 is probably going to be the de facto standard, which very
>>> many people want to use, because it has all the new features, which won't be
>>> ported to ext2/3. So I still don't understand, what's so wrong about a
>>> little tuning in both directions?
>> Just seems like wasted effort to me.
> 
> I disagree.
> Many developer still brag about how Linux runs on about everything, but 
> it's little steps like this, which make it more and more a joke.

What joke?  With CONFIG_LBD, 32-bit machines can already support large 
block devices.

If you feel that hardcoding u64 as sector numbers will mean ext4 
suddenly fails on 32-bit, you misunderstand the situation completely.

Linux (and ext4) will continue to run everywhere.

	Jeff



