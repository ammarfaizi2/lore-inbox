Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262409AbVAUQUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbVAUQUL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 11:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbVAUQUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 11:20:10 -0500
Received: from relay.muni.cz ([147.251.4.35]:58246 "EHLO tirith.ics.muni.cz")
	by vger.kernel.org with ESMTP id S262409AbVAUQUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 11:20:05 -0500
Date: Fri, 21 Jan 2005 17:19:59 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Memory leak in 2.6.11-rc1?
Message-ID: <20050121161959.GO3922@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

I've been running 2.6.11-rc1 on my dual opteron Fedora Core 3 box for a week
now, and I think there is a memory leak somewhere. I am measuring the
size of active and inactive pages (from /proc/meminfo), and it seems
that the count of sum (active+inactive) pages is decreasing. Please
take look at the graphs at

http://www.linux.cz/stats/mrtg-rrd/vm_active.html

(especially the "monthly" graph) - I've booted 2.6.11-rc1 last Friday,
and since then the size of "inactive" pages is decreasing almost
constantly, while "active" is not increasing. The active+inactive
sum has been steady before, as you can see from both the monthly
and yearly graphs.

Now I am playing with 2.6.11-rc1-bk snapshots to see what happens.
I have been running 2.6.10-rc3 before. More info is available, please ask me.
The box runs 3ware 7506-8 controller with SW RAID-0, 1, and 5 volumes,
Tigon3 network card. The main load is FTP server, and there is also
a HTTP server and Qmail.

	Thanks,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
