Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262494AbVAVCY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbVAVCY2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 21:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbVAVCY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 21:24:28 -0500
Received: from mailfe06.swip.net ([212.247.154.161]:27804 "EHLO
	mailfe06.swip.net") by vger.kernel.org with ESMTP id S262494AbVAVCYX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 21:24:23 -0500
X-T2-Posting-ID: 2Ngqim/wGkXHuU4sHkFYGQ==
Subject: Re: Memory leak in 2.6.11-rc1?
From: Alexander Nyberg <alexn@dsv.su.se>
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050121161959.GO3922@fi.muni.cz>
References: <20050121161959.GO3922@fi.muni.cz>
Content-Type: text/plain
Date: Sat, 22 Jan 2005 03:23:59 +0100
Message-Id: <1106360639.15804.1.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fre 2005-01-21 klockan 17:19 +0100 skrev Jan Kasprzak:
> 	Hi all,
> 
> I've been running 2.6.11-rc1 on my dual opteron Fedora Core 3 box for a week
> now, and I think there is a memory leak somewhere. I am measuring the
> size of active and inactive pages (from /proc/meminfo), and it seems
> that the count of sum (active+inactive) pages is decreasing. Please
> take look at the graphs at
> 
> http://www.linux.cz/stats/mrtg-rrd/vm_active.html
> 
> (especially the "monthly" graph) - I've booted 2.6.11-rc1 last Friday,
> and since then the size of "inactive" pages is decreasing almost
> constantly, while "active" is not increasing. The active+inactive
> sum has been steady before, as you can see from both the monthly
> and yearly graphs.
> 
> Now I am playing with 2.6.11-rc1-bk snapshots to see what happens.
> I have been running 2.6.10-rc3 before. More info is available, please ask me.
> The box runs 3ware 7506-8 controller with SW RAID-0, 1, and 5 volumes,
> Tigon3 network card. The main load is FTP server, and there is also
> a HTTP server and Qmail.

Others have seen this as well, the reports indicated that it takes a day
or two before it becomes noticeable. When it happens next time please
capture the output of /proc/meminfo and /proc/slabinfo.

Thanks
Alexander

