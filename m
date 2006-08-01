Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932558AbWHALAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbWHALAo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbWHALAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:00:44 -0400
Received: from cibs10.sns.it ([192.167.206.30]:61573 "EHLO reed.sns.it")
	by vger.kernel.org with ESMTP id S932558AbWHALAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:00:43 -0400
Date: Tue, 1 Aug 2006 12:59:41 +0200 (CEST)
From: venom@sns.it
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: Adrian Ulrich <reiser4@blinkenlights.ch>,
       Matthias Andree <matthias.andree@gmx.de>, vonbrand@inf.utfsm.cl,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
In-Reply-To: <20060801104013.GA18239@aitel.hist.no>
Message-ID: <Pine.LNX.4.64.0608011255150.10035@Expansa.sns.it>
References: <1153760245.5735.47.camel@ipso.snappymail.ca>
 <200607241806.k6OI6uWY006324@laptop13.inf.utfsm.cl>
 <20060731125846.aafa9c7c.reiser4@blinkenlights.ch> <20060731144736.GA1389@merlin.emma.line.org>
 <20060731175958.1626513b.reiser4@blinkenlights.ch> <20060801104013.GA18239@aitel.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

planning sometimes is not possible, exspecially in certain highly stressed 
environment.

Just think. I had 3 years ago a database that was 2 TB, we were supposing 
it could grow in three years of 6 TB, but now it is 40 TB because
the market situation is changed, and with this the number of the users and 
their needs.

Please you have to suppose that when you 
have to deal with filesystems use for some kind of services, it is 
impossible to predict the grown rate, and this is true also about the 
numeber of used i-nodes.



On Tue, 1 Aug 2006, Helge Hafting wrote:

> On Mon, Jul 31, 2006 at 05:59:58PM +0200, Adrian Ulrich wrote:
>> Hello Matthias,
>>
>>> This looks rather like an education issue rather than a technical limit.
>>
>> We aren't talking about the same issue: I was asking to do it
>> on-the-fly. Umounting the filesystem, running e2fsck and resize2fs
>> is something different ;-)
>>
>>> Which is untrue at least for Solaris, which allows resizing a life file
>>> system. FreeBSD and Linux require an unmount.
>>
>> Correct: You can add more inodes to a Solaris UFS on-the-fly if you are
>> lucky enough to have some free space available.
>>
>> A colleague of mine happened to create a ~300gb filesystem and started
>> to migrate Mailboxes (Maildir-style format = many small files (1-3kb))
>> to the new LUN. At about 70% the filesystem ran out of inodes; Not a
>> big deal with VxFS because such a problem is fixable within seconds.
>> What would have happened if he had used UFS? mkfs -G wouldn't work
>> because he had no additional Diskspace left... *ouch*..
>>
> This case is solvable by planning.  When you know that the new fs
> must be created with all inodes from the start, simply count
> how many you need before migration.  (And add a decent safety margin.)
> That's what I do with my home machine ask disks wear out every third
> year or so. The tools for ext2/3 tells how many inodes are in use,
> and the new fs can be made accordingly.  The approach works for bigger
> machines too of course.
>
> Helge Hafting
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
