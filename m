Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWFNH7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWFNH7P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 03:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWFNH7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 03:59:15 -0400
Received: from cool.dworf.com ([193.189.190.81]:31555 "EHLO cool.dworf.com")
	by vger.kernel.org with ESMTP id S1751208AbWFNH7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 03:59:14 -0400
Message-ID: <448FC1CE.9090108@dworf.com>
Date: Wed, 14 Jun 2006 09:59:10 +0200
From: David Osojnik <david@dworf.com>
Reply-To: david@dworf.com
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: bad command responsiveness Proliant DL 585
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We have a problem with four HP Proliant DL 585 servers with 4 AMD
Opteron processors and 16Gb of memory and 3x 300Gb U320 SCSI disks and
with all the latest firmware. we noticed bad command responsiveness in
an production environment and poor performance (web server and mysql)
The problem is good reproducible if creating a large file 30Gb in size with:

time dd if=/dev/zero of=test.file bs=3072 count=10240000

on the root partition no matter which one reiserfs, ext3

what happens is I open three more console windows and do random commands
like: "ls, w, route -n, ifconfig" but the commands freezes for random
time (this time is from 1 minute to 15minutes!! per command execution
time) when the command starts working (after 5minutes) i try it again
and the command freezes again for a random time... the strange thing is
that if one command freezes all other commands freeze too when one
starts to work others work too. (if running top it stops refreshing for
the lockup period)

we tried raid0, raid1, raid5 its the same and we even tried some other
raid controllers other then default onboard Smart Array 5i we tried
Smart Array 6402 and MegaRAID SCSI 320-2X. The problem is still there
the only difference is writing speed but the lockups are still there!

and we tried this on four different DL 585 servers with all the same
problem!

load when creating 32Gb file was around 10 (starting creation of the
file with load 0.05) and the system did not run any services except the
default (after a fresh minimum install of more then one distribution) we
tried it too with all services shutdown and as much modules unloaded as
we could remove.

we tried lots of kernels and cciss modules but all have the problem
including 2.6.16.20

only the kernel 2.4 was working better there were still the lockups but
were less often and commands executed faster around 50%.

why am i writing to kernel list because it looks like a kernel problem
to me since the kernel 2.4 looks much better.

hope someone can help because we are getting really desperate

thanks
