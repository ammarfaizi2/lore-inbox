Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263140AbTIGAGy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 20:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbTIGAGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 20:06:54 -0400
Received: from mail.skjellin.no ([80.239.42.67]:7351 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S263140AbTIGAGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 20:06:51 -0400
Message-ID: <3F5A7699.9080208@tomt.net>
Date: Sun, 07 Sep 2003 02:06:49 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030820 Mozilla Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, mingo@redhat.com
Subject: Re: md: bug in file md.c, line 1440 (2.4.22)
References: <3F5017CA.4080700@tomt.net> <16213.14893.955734.797630@gargle.gargle.HOWL>
In-Reply-To: <16213.14893.955734.797630@gargle.gargle.HOWL>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> Your problem is that these extra slots (N:0) are flagged as failed
> (S:9) and this confuses md.c.
> 
> If you get mdadm 1.3.0 and apply the three patches that can be found
> in
>    http://cgi.cse.unsw.edu.au/~neilb/source/mdadm/patch/applied/
> 
> and then stop the array and use:
>    mdadm --assemble --update=summaries /dev/md5 /dev/sda9 /dev/sdc9
> 
> then it should fix things up for you.
> You will need to do a similar thing for all of the arrays.
> This will be difficult for md2 as it is 'root'.  You will need to boot
> a rescue disc to fix this one.
> 
> I have not idea how it got the failed flag.

I didn't read this in time to get this tested - I did a full backup and 
restore earlier, zeroing all sectors on both drives. All is fine now, 
however I have no idea how this has happened. I'll set one partition 
faulty, re-add it and reboot later just to make sure it really works.

2.6 has never been booted on that machine, or disks.

Thanks, I'll keep mdadm in mind next time something like this happens ;-)

-- 
Cheers,
André Tomt
andre@tomt.net

