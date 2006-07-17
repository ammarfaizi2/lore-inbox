Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbWGQWeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWGQWeZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 18:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWGQWeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 18:34:25 -0400
Received: from science.horizon.com ([192.35.100.1]:33582 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751096AbWGQWeY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 18:34:24 -0400
Date: 17 Jul 2006 18:34:23 -0400
Message-ID: <20060717223423.24205.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu
Subject: Re: Reiser4 Inclusion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I have deployed two nearly identical servers in Florida (I live in
>> Washington state) but one difference: one uses ext3 and the other
>> reiser4. The ping time of the reiser4 server is (on average) 20ms faster
>> than the ext3 server.
>
> OK, I'll bite.  What *POSSIBLE* reason is there for the choice of filesystem
> to matter to an ICMP Echo Request/Reply?  I'm suspecting something else,
> like the ext3 server needs to re-ARP before sending the Echo Reply, or some
> such.

Er... I was assuming that was an application-level ping, e.g. "fetch
database-generated web page", and not an ICMP-level ping.

If this *is* talking about ICMP-level ping, I agree completely;
that makes no sense.  Either there is a dire bug in Linux networking,
or the networks aren't the same.  Assuming the two machines are
located together (if they're not, there's your problem right there),
is the same 20 ms visible when you ping them from each other?
