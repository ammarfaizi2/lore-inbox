Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbUDWWR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUDWWR0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 18:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUDWWRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 18:17:25 -0400
Received: from ptb-relay02.plus.net ([212.159.14.213]:46353 "EHLO
	ptb-relay02.plus.net") by vger.kernel.org with ESMTP
	id S261605AbUDWWRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 18:17:23 -0400
Message-ID: <408996B6.6070105@mauve.plus.com>
Date: Fri, 23 Apr 2004 23:20:38 +0100
From: Ian Stirling <ian.stirling@mauve.plus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joel Jaeggli <joelja@darkwing.uoregon.edu>
CC: "Richard B. Johnson" <root@chaos.analogic.com>, Paul Jackson <pj@sgi.com>,
       Timothy Miller <miller@techsource.com>, tytso@mit.edu,
       miquels@cistron.nl, linux-kernel@vger.kernel.org
Subject: Re: File system compression, not at the block layer
References: <Pine.LNX.4.44.0404231410130.27087-100000@twin.uoregon.edu>
In-Reply-To: <Pine.LNX.4.44.0404231410130.27087-100000@twin.uoregon.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Jaeggli wrote:
> On Fri, 23 Apr 2004, Richard B. Johnson wrote:
> 
>>If you want to have fast disks, then you should do what I
>>suggested to Digital 20 years ago when they had ST-506
>>interfaces and SCSI was available only from third-parties.


> except disks no longer encode one bit at a time (with prml), and you're
> still serializing requests across all the spindles instead of dividing
> requests between spindles... it's pretty clear that in the forseeable
> future capacity grown will continue to far outstrip access speed in
> spinning magnetic media. I would agree that any serious improvement is


I happened to do some sums about a week ago.

My first drive was ST225R, which was 60M,3600RPM and the whole drive could be
read in 2 or 3 mins.
My new 160G drive is 7200RPM, and reads in around 50 mins.

It's not a complete coincidence that sqrt(160/.06) is about 50, and the number
of revs to read the drive is pretty much dead on 50 times.

The areal density of disk drives tends to go up both by adding more tracks, and
by squeezing the data into each track more densely.

While you can speed up the disk maybe 5 times if you are willing to pay the price,
the increasing number of tracks means that you'r still going to need lots more
revs to read the drive.

