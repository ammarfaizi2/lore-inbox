Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965101AbWCUUCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbWCUUCK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 15:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965102AbWCUUCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 15:02:09 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:8458 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S965101AbWCUUCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 15:02:08 -0500
Message-ID: <44205BC5.9040200@cfl.rr.com>
Date: Tue, 21 Mar 2006 15:02:13 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: VFAT: Can't create file named 'aux.h'?
References: <1142890822.5007.18.camel@localhost.localdomain> <20060320134533.febb0155.rdunlap@xenotime.net> <dvn835$lvo$1@terminus.zytor.com> <Pine.LNX.4.61.0603211840020.21376@yvahk01.tjqt.qr> <44203B86.5000003@zytor.com> <Pine.LNX.4.61.0603211854150.21376@yvahk01. <442050C8.1020200@zytor.com>
In-Reply-To: <442050C8.1020200@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Mar 2006 20:02:20.0732 (UTC) FILETIME=[5CC59FC0:01C64D22]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14337.000
X-TM-AS-Result: No--7.300000-5.000000-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Probably it would be worth trying to create "aux.h" under XP and see 
> what happens.  Unfortunately I don't have a 'doze system handy at the 
> moment.

kernel32.dll's CreateFile() and other apis normally perform translation 
which includes special handling for dos device names including AUX.  You 
can bypass this by prefixing the absolute file name with the string 
"\\?\" and this will allow you to create a file named AUX.  It also 
allows you to reference file names with absolute paths greater than 255 
characters.


