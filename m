Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVB1FN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVB1FN5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 00:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVB1FN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 00:13:56 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:39855 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261560AbVB1FNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 00:13:49 -0500
Message-ID: <4222A887.80301@yahoo.com.au>
Date: Mon, 28 Feb 2005 16:13:43 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Schmid <webmaster@rapidforum.com>
CC: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Slowdown on high-load machines with 3000 sockets
References: <4221FB13.6090908@rapidforum.com> <Pine.LNX.4.61.0502271216050.19979@chimarrao.boston.redhat.com> <Pine.LNX.4.61.0502271606220.19979@chimarrao.boston.redhat.com> <422239A8.1090503@rapidforum.com> <Pine.LNX.4.61.0502271830380.19979@chimarrao.boston.redhat.com> <42225B34.7020104@rapidforum.com> <Pine.LNX.4.61.0502271905270.19979@chimarrao.boston.redhat.com> <42226607.6020803@rapidforum.com>
In-Reply-To: <42226607.6020803@rapidforum.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schmid wrote:
> I already tried with 300 KB and even used a perl-hash as a horrible-slow 
> buffer for a readahead-replacement. It still slowed down on the syswrite 
> to the socket. Thats the strange thing.
> 

Do you have to use manual readahead though? What is the performance
like if you just let the kernel do its own thing? The kernel's
readahead provides things like automatic scaling and thrashing
control, so if possible you should just stick to that.

Although you may want to experiment with the maximum readahead on your
working disks:
/sys/block/???/queue/read_ahead_kb

Also, can we get a testcase (ie. minimal compilable code) to reproduce
this problem?

Thanks,
Nick

