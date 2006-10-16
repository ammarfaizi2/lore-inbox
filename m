Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422897AbWJPVV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422897AbWJPVV3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 17:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422898AbWJPVV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 17:21:29 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:37015 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1422897AbWJPVV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 17:21:28 -0400
Message-ID: <4533F7CA.3070405@oracle.com>
Date: Mon, 16 Oct 2006 14:21:14 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: AIO, DIO fsx tests failures on 2.6.19-rc1-mm1
References: <1161013338.32606.2.camel@dyn9047017100.beaverton.ibm.com>	<4533C6A1.40203@oracle.com>	<1161021586.32606.6.camel@dyn9047017100.beaverton.ibm.com>	<4533E7E2.6010506@oracle.com>	<1161031099.32606.14.camel@dyn9047017100.beaverton.ibm.com> <20061016135910.be11a2dc.akpm@osdl.org>
In-Reply-To: <20061016135910.be11a2dc.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Hmm.. with that patch applied, I still have fsx failures.
>> This time read() returning -EINVAL. Are there any other fixes
>> missing in -mm ?

For what it's worth, the fsx I have here isn't raising errors with the
latest patch on 1k, 2k, and 4k ext3 on a stinky old IDE drive on an old
UP P3.

# /tmp/fsx -N 10000 -o 128000 -r 2048 -w 4096 -Z -R -W
/mnt/ext3-hdb4/fsx-file
...
truncating to largest ever: 0x3ff9f
truncating to largest ever: 0x3ffa9
All operations completed A-OK!

- z
