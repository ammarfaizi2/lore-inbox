Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbUCSUEr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 15:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUCSUEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 15:04:47 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:32474 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261885AbUCSUEq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 15:04:46 -0500
Message-ID: <405B525D.6080006@namesys.com>
Date: Fri, 19 Mar 2004 23:04:45 +0300
From: Hans Reiser <reiser@namesys.com>
Reply-To: reiser@namesys.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Peter Zaitsev <peter@mysql.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: True  fsync() in Linux (on IDE)
References: <1079572101.2748.711.camel@abyss.local>	 <20040318064757.GA1072@suse.de> <1079639060.3102.282.camel@abyss.local>	 <20040318194745.GA2314@suse.de>  <1079640699.11062.1.camel@watt.suse.com>	 <1079641026.2447.327.camel@abyss.local>	 <1079642001.11057.7.camel@watt.suse.com>	 <1079642801.2447.369.camel@abyss.local>	 <1079643740.11057.16.camel@watt.suse.com>	 <1079644190.2450.405.camel@abyss.local>	 <1079644743.11055.26.camel@watt.suse.com>  <405AA9D9.40109@namesys.com>	 <1079704347.11057.130.camel@watt.suse.com>  <405B4BA3.2030205@namesys.com> <1079726221.11058.174.camel@watt.suse.com>
In-Reply-To: <1079726221.11058.174.camel@watt.suse.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:

>On Fri, 2004-03-19 at 14:36, Hans Reiser wrote:
>
>  
>
>>I hope I am totally off-base and not understanding you....  Please help 
>>me here.
>>    
>>
>
>Lets look at actual scope of the problem:
>
>filesystem metadata
>filesystem data (fsync, O_SYNC, O_DIRECT)
>block device data (fsync, O_SYNC, O_DIRECT)
>
>Multiply the cases above times each filesystem and also times md and
>device mapper, since the barriers need to aggregate down to all the
>drives.
>
>In other words, just fixing fsync in 2.4 is not enough, and there is
>still considerable development needed in 2.6.  Maybe after all the 2.6
>changes are done and accepted we can consider backporting parts of it to
>2.4.
>
>-chris
>
>
>
>
>  
>
In 2.6 does fsync always insert a write barrier when the metadata 
journaling option is set for reiserfs?

-- 
Hans

