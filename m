Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266093AbTFWSm2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 14:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266095AbTFWSm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 14:42:28 -0400
Received: from [203.149.0.18] ([203.149.0.18]:40947 "EHLO
	krungthong.samart.co.th") by vger.kernel.org with ESMTP
	id S266093AbTFWSm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 14:42:27 -0400
Message-ID: <3EF74DBF.6000703@thai.com>
Date: Tue, 24 Jun 2003 01:58:07 +0700
From: Samphan Raruenrom <samphan@thai.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030320
X-Accept-Language: th,en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Crusoe's performance on linux?
References: <3EF1E6CD.4040800@thai.com> <20030619200308.A2135@ucw.cz> <3EF2144D.5060902@thai.com> <20030619221126.B3287@ucw.cz> <3EF67AD4.4040601@thai.com> <20030623102623.A18000@ucw.cz>
In-Reply-To: <20030623102623.A18000@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Mon, Jun 23, 2003 at 10:58:12AM +0700, Samphan Raruenrom wrote:
>>Desktop - Pentium III 1 G Hz 754 MB	->	10.x min.
>>Tablet PC - Crusoe TM5800 1 GHz 731 MB	->	17.x min.
>> From freshdiagnos benchmack, the TPC has about 2x faster RAM.
>>I use tmpfs for the whole process so disk speed didn't count.
>>Both test run without X or any foreground process using
>>2.4.21-ac1 and RedHat kernel.
> Desktop - 1.1 GHz Athlon Tbird 512M RAM, using disk -> 3.7 min
> This is with gcc 2.95.2, which may give it an unfair advantage, though.
> Or is something else wrong here?

Both use gcc 3.2.  The desktop pentium III is very old. Slow ram/bus may 
be the
reason. Or this may be the fastest a pentium iii 1 MHz can perform?.
Large RAM don't help pentium III. It doesn't need them here.
Large RAM should help Cursoe a lot. CMS should use those RAM as traslation
cache and put the entire processes (make, gcc, as) in it.
I guess 17.x min kernel compile time result from CMS still taking time 
interpreting x86
code (because it decide to do so to conserve translation cache space?).
I wish the linux kernel could hint CMS to do a better job, if possible, like
when to interpret, translate or fully optimize and save-to-disk for 
later use.




