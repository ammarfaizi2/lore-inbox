Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVAGIU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVAGIU2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 03:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVAGIU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 03:20:28 -0500
Received: from l247169.ppp.asahi-net.or.jp ([218.219.247.169]:48281 "EHLO
	web2.davelinux.com") by vger.kernel.org with ESMTP id S261311AbVAGIUV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 03:20:21 -0500
Message-ID: <35179.210.175.245.132.1105085918.squirrel@www.davelinux.com>
In-Reply-To: <20050107002333.21133.qmail@web52602.mail.yahoo.com>
References: <20050107002333.21133.qmail@web52602.mail.yahoo.com>
Date: Fri, 7 Jan 2005 17:18:38 +0900 (JST)
Subject: Re: how to find all threads of a given process?
From: "David Blomberg" <dblomber@davelinux.com>
To: linux-kernel@vger.kernel.org
Reply-To: dblomber@davelinux.com
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jesse said:
> suppose I already know the PID of a process, how could
> i quickly identify all threads of this process?
>
> As i know, under /proc, threads of all processes have
> prefix ".", one way is to iterate each one and do the
> check. the approach is too expensive. any other
> suggestions?
>
> for instance,

wouldn't this be easier in user space using "ps H" then one of two options
happens depending on the use of fork and other issues (making the question
hard to answer as stated) either A: they will all have the same PID or
B:they will all have varying PIDs in the later case you could use looks
for all PIDs sharing the same ancestor PPID (depending on how far down you
are in the fork list)
