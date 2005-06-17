Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbVFQQga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVFQQga (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 12:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbVFQQga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 12:36:30 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:27048 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S262015AbVFQQgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 12:36:19 -0400
Message-ID: <42B2FBF3.6010607@nortel.com>
Date: Fri, 17 Jun 2005 10:36:03 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Robert Love <rml@novell.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Zach Brown <zab@zabbo.net>, linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] inotify, improved.
References: <1118855899.3949.21.camel@betsy> <42B1BC4B.3010804@zabbo.net> <1118946334.3949.63.camel@betsy> <42B227B5.3090509@yahoo.com.au> <1118972109.7280.13.camel@phantasy> <1119021336.3949.104.camel@betsy> <42B2EE31.9060709@nortel.com>            <1119023078.3949.115.camel@betsy> <200506171611.j5HGBFY8012609@turing-police.cc.vt.edu>
In-Reply-To: <200506171611.j5HGBFY8012609@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

> It's also racy as hell.  By the time the inotify gets delivered to the
> userspace process, pid 820 may be long gone.....

Yep.  But I can see uses for people to want to log all activity on 
specific directory trees.  Think audit trails, etc.

Imagine root getting a log like:

Date: Jan 1,2006: file /foo/evidence.txt changed by user blah, pid 
<666>, commandline: "vi evidence.txt"

Chris
