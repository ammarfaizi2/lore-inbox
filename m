Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932673AbVJGVf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673AbVJGVf7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 17:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932675AbVJGVf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 17:35:59 -0400
Received: from smarthost1.mail.uk.easynet.net ([212.135.6.11]:38669 "EHLO
	smarthost1.mail.uk.easynet.net") by vger.kernel.org with ESMTP
	id S932673AbVJGVf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 17:35:59 -0400
Message-ID: <4346EA35.90700@uklinux.net>
Date: Fri, 07 Oct 2005 22:35:49 +0100
From: Jon Burgess <jburgess@uklinux.net>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gilbertd@treblig.org
CC: subbie_subbie@yahoo.com, vherva@vianova.fi, linux-kernel@vger.kernel.org
Subject: Re: 3Ware 9500S-12 RAID controller -- poor performance
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You might be interested in trying a small tool I wrote to perform some 
parallel write tests on different linux filesystems.

http://marc.theaimsgroup.com/?l=linux-kernel&m=107661735307313&w=2

At the time that I wrote the tool, 18 months ago, both ext3 and 
reiserfsV3 performed fairly badly at handling concurrent writes and only 
JFS and XFS excelled. Since then I believe the ext3 performance has been 
greatly improved due to the block reservation scheme added in 2.6.10. 
AFAIK the reiserfs performance is only addressed in reiserfsV4.

The test code is fairly trivial and could be easily adapted to simulate 
other workloads (like a web server) to help to optimise your filesystem 
and driver performance.

tiobench provides another threaded IO test http://tiobench.sourceforge.net/

	Jon

