Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbVIKI6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbVIKI6E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 04:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbVIKI6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 04:58:03 -0400
Received: from main.gmane.org ([80.91.229.2]:16359 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932458AbVIKI6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 04:58:02 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: read-from-all-disks support for RAID1?
Date: Sun, 11 Sep 2005 17:55:26 +0900
Message-ID: <dg0rfb$vf9$1@sea.gmane.org>
References: <20050910123902.GA9461@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050804)
X-Accept-Language: en-us, en
In-Reply-To: <20050910123902.GA9461@xi.wantstofly.org>
X-Enigmail-Version: 0.92.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennert Buytenhek wrote:
> (please CC on replies)
> 
> Hi!
> 
> I recently had a case where one disk in a two-disk RAID1 array went
> subtly bad, effectively refusing to write to certain sectors without
> reporting an error.  Basically, parts of the disk went undetectably
> read-only, causing file system corruption that wouldn't go away after
> fsck, and all kinds of other fun.
> 
> Would it be hard/wise to add an option for RAID1 mode to read from all
> devices on a read, and report an error to syslog or simply return an
> I/O error if there is a mismatch?  (Or use majority voting and tell
> people to use 3-disk RAID1 arrays from now on ;-)

Well, an option might be good for debugging, but it will lower performance
a lot, IMHO.

As log as 3-drive RAID1 is concerned :-) You'd better get RAID3 or 2
more drives and RAID5.

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

