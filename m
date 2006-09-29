Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161821AbWI2RHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161821AbWI2RHO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 13:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161824AbWI2RHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 13:07:12 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:17812 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1161529AbWI2RHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 13:07:09 -0400
Date: Fri, 29 Sep 2006 19:06:21 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: girish <girishvg@gmail.com>
cc: linux-kernel@vger.kernel.org, William Pitcock <nenolod@atheme.org>
Subject: Re: [PATCH] include children count, in Threads: field present in
 /proc/<pid>/status (take-1)
In-Reply-To: <EE7C757E-E2CE-4617-A1D4-3B8F5E3E8240@gmail.com>
Message-ID: <Pine.LNX.4.61.0609291905550.27518@yvahk01.tjqt.qr>
References: <0635847A-C149-412C-92B1-A974230381F8@dts.local>
 <F2F2C98F-6AFB-4E19-BEE9-D32652E2F478@atheme.org> <EE7C757E-E2CE-4617-A1D4-3B8F5E3E8240@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > 
>> > -	buffer += sprintf(buffer, "Threads:\t%d\n", num_threads);
>> > +	buffer += sprintf(buffer, "Threads:\t%d\n", num_threads +
>> > num_children);
>> 
>> Personally, I'd prefer the children count to be separate, something like:
>> 
>> buffer += sprintf(buffer, "Threads:\t%d (%d children, %d total)",
>> num_threads, num_children, num_threads + num_children);
>> 
>> That would be rather nice, indeed.

And I would suggest three separate lines to keep it parseable!


Jan Engelhardt
-- 
