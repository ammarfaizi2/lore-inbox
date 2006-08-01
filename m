Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161001AbWHAEY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161001AbWHAEY2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 00:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbWHAEY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 00:24:28 -0400
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:50589 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1161001AbWHAEY1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 00:24:27 -0400
Message-ID: <44CED777.5080308@slaphack.com>
Date: Mon, 31 Jul 2006 23:24:23 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: tdwebste2@yahoo.com
CC: Theodore Tso <tytso@mit.edu>, Nate Diller <nate.diller@gmail.com>,
       David Lang <dlang@digitalinsight.com>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of view"
 expressed by kernelnewbies.org regarding reiser4 inclusion]
References: <20060801034726.58097.qmail@web51311.mail.yahoo.com>
In-Reply-To: <20060801034726.58097.qmail@web51311.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Webster wrote:
> Different users have different needs.

I'm having trouble thinking of users who need an FS that doesn't need a 
repacker.

The disk error problem, though, you're right -- most users will have to 
get bitten by this, hard, at least once, or they'll never get the 
importance of it.  But it'd be nice if it's not too hard, and we can 
actually recover most of their files.

Still, I can see most people who are aware of this problem using RAID, 
backups, and not caring if their filesystem tolerates bad hardware.

> The problem I see is managing disk errors.

I see this kind of the same way.  If your disk has errors, you should be 
getting a new disk.  If you can't do that, you can run a mirrored RAID 
-- even on SATA, you should be able to hotswap it.

Even for a home/desktop user, disks are cheap, and getting cheaper all 
the time.  All you have to do is run the mean time between failure 
numbers by them, and ask them if their backup is enough.

> And perhaps a
> really good clustering filesystem for markets that
> require NO downtime. 

Thing is, a cluster is about the only FS I can imagine that could 
reasonably require (and MAYBE provide) absolutely no downtime. 
Everything else, the more you say it requires no downtime, the more I 
say it requires redundancy.

Am I missing any more obvious examples where you can't have enough 
redundancy, but you can't have downtime either?
