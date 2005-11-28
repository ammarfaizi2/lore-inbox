Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbVK1M15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbVK1M15 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 07:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbVK1M15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 07:27:57 -0500
Received: from mailgate-out2.mysql.com ([213.136.52.68]:24755 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S1751269AbVK1M15
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 07:27:57 -0500
Message-ID: <438AF860.7050905@mysql.com>
Date: Mon, 28 Nov 2005 13:30:24 +0100
From: Jonas Oreland <jonas@mysql.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.11) Gecko/20050915
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RT] read_tsc: ACK! TSC went backward! Unsynced TSCs?
References: <1133179554.11491.3.camel@localhost.localdomain>
In-Reply-To: <1133179554.11491.3.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> Hi Ingo,
> 
> With -rt20 on the AMD64 x2, I'm getting a crap load of these:
> 
> read_tsc: ACK! TSC went backward! Unsynced TSCs?
> 
> So bad that the system wont even boot (at least I won't wait long enough
> to let it finish).
> 
> config at: http://www.kihontech.com/tests/rt/config

Check this: http://bugzilla.kernel.org/show_bug.cgi?id=5105

Booting with idle=poll, fixes that.

Hope it help

/Jonas
