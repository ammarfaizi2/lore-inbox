Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291301AbSBMBvt>; Tue, 12 Feb 2002 20:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291291AbSBMBva>; Tue, 12 Feb 2002 20:51:30 -0500
Received: from chabotc.xs4all.nl ([213.84.192.197]:43925 "EHLO
	chabotc.xs4all.nl") by vger.kernel.org with ESMTP
	id <S291298AbSBMBvT>; Tue, 12 Feb 2002 20:51:19 -0500
Message-ID: <3C69C5A6.4020409@reviewboard.com>
Date: Wed, 13 Feb 2002 02:47:18 +0100
From: Chris Chabot <chabotc@reviewboard.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020206
X-Accept-Language: en-us
MIME-Version: 1.0
CC: Mukund Ingle <inglem@cisco.com>, linux-kernel@vger.kernel.org
Subject: Re: Quick question on Software RAID support.
In-Reply-To: <E16aoUH-0003mY-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>1) Does the Software RAID-5 support automatic detection
>>     of a drive failure? How?
>>
> 
> It sees the commands failing on the underlying controller. Set up a software
> raid 5 and just yank a drive out of a  bay if you want to test it

This is also why software raid 5 + IDE is a bad combo. It has a high 
chance of locking up the IDE controller, and requiring you to power down 
& fix the system before reconstruction can commence. However with SCSI 
hot-swapable solutions, on-the-fly reconstruction after failure works 
perfectly.


>>2) Has Linux Software RAID-5 been used in the Enterprise environment
>>     to support redundancy by any real-world networking company
>>     or this is just a tool used by individuals to provide redundancy on
>>     their own PCs in the labs and at home?
>>
> 
> Dunno about that. I just hack code 8)

I am using software raid 5 and several Dell PowerEdge 2550 servers 
(since the hardware raid was to slow for some heavy IO operations), with 
great results. We have had 5 seperate disk failures so far, and no 
problems what so ever. Either the spare disk kicked right in, or after 
adding the new drive, reconstruction work perfectly.


I don't know if 20 PE2550 servers qualifies as a 'enterprise' solution,

but it works great for the kinds of thing we are doing

	--Chris

