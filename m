Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030473AbWIMBTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030473AbWIMBTQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 21:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030474AbWIMBTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 21:19:15 -0400
Received: from 207-71-50-114.static.twtelecom.net ([207.71.50.114]:49884 "HELO
	mail.ticom-geo.com") by vger.kernel.org with SMTP id S1030473AbWIMBTO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 21:19:14 -0400
Message-ID: <45075C6A.6040808@ticom-geo.com>
Date: Tue, 12 Sep 2006 20:18:34 -0500
From: Rudy Klinksiek <rklinksiek@ticom-geo.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ext2/ext3 balancing streaming io  -  help
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

Don't know if this is the right list, if not I apologize and
ask someone to point me to right mailing list.

For 2.4.27 with low-latency patches, is there a way to balance
data streaming in ( around 4-8Mb/sec )with writing it to disk, using
an ext2 or ext3 filesystem.  The system has a single disk, and can
sustain 10-20MB/sec for 2-4 secs.  And  yes I'm stuck with this
particular system.

Twiddling with bdflush parameters, I had a setup that was doing this
( monitoring with "vmstat 1" ) but it is not really reproducible.
Mostly, data is flushed out in chunks, often 1/2/3 secs with
nothing written in between flushes. Eventually freemem is depleted,
with cache increasing, but the rate going out to disk is still
generally less than the ncoming rate.

After shutting down the input side, it takes many 10's of secs for
vmstat to show nothing going to disk.

"bdflush" doesn't seem to have enough/correct knobs to effect a 
"streaming" mode.

Or am I missing something here? 
Any other tunable parameters?

Any help appreciated
klink

