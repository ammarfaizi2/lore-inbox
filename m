Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUDPRey (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 13:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUDPRey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 13:34:54 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:9147 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261169AbUDPRex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 13:34:53 -0400
Subject: Re: Huge iowait on 2.6.4 - not on 2.4.20 !
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: alandpearson@yahoo.com
Content-Type: text/plain
Organization: 
Message-Id: <1082128366.849.60.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 16 Apr 2004 11:12:47 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan pearson writes:

> On 2.6 the iowait jumps to around 70%, while 2.4 on
> both tests it is firmly zero.

The 2.4 kernel lumps iowait into idle, so you
won't see iowait on a 2.4 kernel.

> On disk read, I'm loosing 30 Mb/sec of bandwidth PER
> DISK, compared to 2.4.20.
> I've tried using both the deadline and as ioschedulers
> but no difference.
>
>
> Under real conditions (ie our application running
> which reads from all the disks simultaneously) on
> 2.6.4, the system performance is around 1/3 of 2.4.20)
>
> Summary MB/Sec :
>
>         dd if=x         dd if=/dev/zero
> 2.4     64              35.6
> 2.6     30.34           35.9

Well, that looks serious, but unfortunately you
can't tell what the iowait was on the 2.4 kernel.
Only the 2.6 kernel provides this information.


