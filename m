Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbTHaPcU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 11:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbTHaPcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 11:32:20 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:64931 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262255AbTHaPcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 11:32:19 -0400
Message-ID: <3F52199B.5020808@kegel.com>
Date: Sun, 31 Aug 2003 08:51:55 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Andrea VM changes
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I spent way too long tweaking the OOM killer before I
realized it was hopeless.
The fact that incoming network traffic can be what causes the
OOM condition makes it Really Hard to decide which app deserves
the axe.

In the test-and-measurement system I'm developing,
it turned out the sanest thing to do with OOM conditions
was to consider them user errors, and to handle them
by dumping memory usage info about processes and slab caches,
then halt.  It's been very helpful because it turns flaky
conditions into rock-solid failures.  Too bad this drastic
approach isn't appropriate for general use.
- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

