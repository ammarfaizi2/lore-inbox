Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbTDHQaO (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 12:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbTDHQaN (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 12:30:13 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:19204 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261469AbTDHQaI (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 12:30:08 -0400
Date: Tue, 8 Apr 2003 18:43:06 +0200
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.67-mm1
Message-ID: <20030408164306.GB568@hh.idb.hist.no>
References: <20030408042239.053e1d23.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030408042239.053e1d23.akpm@digeo.com>
User-Agent: Mutt/1.5.3i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Devfs fails to find all partitions with 2.5.67-mm1, plain 2.5.67 is fine

I have 2 scsi disks, and 2.5.67-mm1 find only some of the partitions
when I boot.  Below is ls -l listings for /dev/discs/disc0 and
/dev/discs/disc1.  Note the missing stuff - linux wasn't at all 
happy when the device for /usr couldn't be found at boot time.
Running cfdisk showed that the partitions were there though.

Helge Hafting

2.5.67-mm1: ls -l /dev/discs/disc0/ 
total 0
brw-rw----    1 root     disk       8,   0 Jan  1  1970 disc
crw-------    1 root     root      21,   0 Jan  1  1970 generic
brw-rw----    1 root     disk       8,   1 Jan  1  1970 part1
brw-rw----    1 root     disk       8,   8 Jan  1  1970 part8

2.5.67:  ls -l /dev/discs/disc0/
totalt 0
brw-rw----    1 root     disk       8,   0 1970-01-01 01:00 disc
crw-------    1 root     root      21,   0 1970-01-01 01:00 generic
brw-rw----    1 root     disk       8,   1 1970-01-01 01:00 part1
brw-rw----    1 root     disk       8,   2 1970-01-01 01:00 part2
brw-rw----    1 root     disk       8,   3 1970-01-01 01:00 part3
brw-rw----    1 root     disk       8,   5 1970-01-01 01:00 part5
brw-rw----    1 root     disk       8,   6 1970-01-01 01:00 part6
brw-rw----    1 root     disk       8,   7 1970-01-01 01:00 part7
brw-rw----    1 root     disk       8,   8 1970-01-01 01:00 part8

And the second disk:
2.5.67-mm1: ls -l /dev/discs/disc1/
total 0
brw-rw----    1 root     disk       8,  16 Jan  1  1970 disc
crw-------    1 root     root      21,   1 Jan  1  1970 generic
brw-rw----    1 root     disk       8,  17 Jan  1  1970 part1
brw-rw----    1 root     disk       8,  18 Jan  1  1970 part2
brw-rw----    1 root     disk       8,  22 Jan  1  1970 part6
brw-rw----    1 root     disk       8,  23 Jan  1  1970 part7
brw-rw----    1 root     disk       8,  24 Jan  1  1970 part8

2.5.67:  ls -l /dev/discs/disc1/
totalt 0
brw-rw----    1 root     disk       8,  16 1970-01-01 01:00 disc
crw-------    1 root     root      21,   1 1970-01-01 01:00 generic
brw-rw----    1 root     disk       8,  17 1970-01-01 01:00 part1
brw-rw----    1 root     disk       8,  18 1970-01-01 01:00 part2
brw-rw----    1 root     disk       8,  21 1970-01-01 01:00 part5
brw-rw----    1 root     disk       8,  22 1970-01-01 01:00 part6
brw-rw----    1 root     disk       8,  23 1970-01-01 01:00 part7
brw-rw----    1 root     disk       8,  24 1970-01-01 01:00 part8



