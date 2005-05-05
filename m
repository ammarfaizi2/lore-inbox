Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbVEEFfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVEEFfl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 01:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbVEEFfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 01:35:32 -0400
Received: from tomts13.bellnexxia.net ([209.226.175.34]:30649 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261896AbVEEFfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 01:35:13 -0400
Date: Thu, 5 May 2005 01:35:11 -0400 (EDT)
From: Chris Gorman <chrisgorman@sympatico.ca>
X-X-Sender: chris@eagle.cgnet.ca
To: linux-kernel@vger.kernel.org
Subject: Re: Kernelpanic - not syncing: VFS: Unable to mount root fs on
 unknown-block
In-Reply-To: <Pine.LNX.4.33.0504292059360.4060-100000@blackbird.cgnet.ca>
Message-ID: <Pine.LNX.4.61.0505050133590.1348@eagle.cgnet.ca>
References: <Pine.LNX.4.33.0504292059360.4060-100000@blackbird.cgnet.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


An upgrade to 2.6.11.8 has solved this problem for me.

Thanks

Chris

On Fri, 29 Apr 2005, Chris Gorman wrote:

> Hello All,
>
> First off, I am not on the linux-kernel list so please cc me directly on
> this if anyone has a solution.  I've experienced a very similar problem
> as S S did while upgrading from 2.6.11.6 to 2.6.11.7.  Essentialy grub
> will boot 2.6.11.6 without any problems, but using the same command line
> 2.6.11.7 fails to boot with "Cannot open root device hde6 or
> unknown-block(0,0)".  The config file used was the same one as 2.6.11.6 so
> I doubt I missed a config option.
>
> The reason I chose to upgrade was because I've been getting ext3 errors
> which caused the journal to crash and the filesystem to be remounted
> read-only.  I hoped the following referenced patch would resolve it.
>
> [PATCH] Prevent race condition in jbd
>
> From: Stephen Tweedie <sct@redhat.com>
> Subject: Prevent race condition in jbd
>
> This patch from Stephen Tweedie which fixes a race in jbd code (it
> demonstrated itself as more or less random NULL dereferences in
> the journal code).
>
> Acked-by: Jan Kara <jack@suse.cz>
> Acked-by: Chris Mason <mason@suse.com>
> Signed-off-by: Chris Wright <chrisw@osdl.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
>
> I only see a few other patches in the Changelog and none appear to me to
> be fs relevant.  Could this be part of our problem?  I've seen one other
> post "Re: Linux 2.6.12-rc2" by hubert.tonneau@fullpliant.org which
> describes the same symptom.  The problem occured during an upgrade from
> 2.6.11 to 2.6.12-rc[12] and this person does have ext3 compiled in.
>
> Also, since grub is common between myself and S S, and my grub is a little
> old, I will try upgrading the program in case that is the problem.
>
> TIA
>
> Chris Gorman
>
> On Apr 18, 2005 S S wrote:
>> I compiled linux kernel 2.6.11.7 on RHEL and while
>> rebooting I get this
>> error message -
>>
>> Cannot open root device /SCSIGroup00/SCSIVol000
>> Please append a correct "root=" boot option
>> Kernelpanic - not syncing: VFS: Unable to mount root
>> fs on
>> unknown-block 0,0
>>
>> This root entry in grub .conf is identical to kernel
>> image entry 2.6.9 which boots fine. However 2.6.11.7
>> compiled kernel does not find
>> /dev//SCSIGroup00/SCSIVol000
>>
>> Could anyone please suggest what could be going wrong.
>
>
