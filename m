Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbUKTHq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbUKTHq4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 02:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbUKTHqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 02:46:46 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:47771 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261174AbUKTHp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 02:45:26 -0500
Message-ID: <419EF60E.4030006@yahoo.com.au>
Date: Sat, 20 Nov 2004 18:45:18 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Linus Torvalds <torvalds@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       akpm@osdl.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: touch_nmi_watchdog (was: page fault scalability patch V11 [0/7]:
 overview)
References: <20041120020306.GA2714@holomorphy.com> <419EBBE0.4010303@yahoo.com.au> <20041120035510.GH2714@holomorphy.com> <419EC205.5030604@yahoo.com.au> <20041120042340.GJ2714@holomorphy.com> <419EC829.4040704@yahoo.com.au> <20041120053802.GL2714@holomorphy.com> <419EDB21.3070707@yahoo.com.au> <20041120062341.GM2714@holomorphy.com> <419EE911.20205@yahoo.com.au> <20041120071514.GO2714@holomorphy.com> <419EF257.8010103@yahoo.com.au>
In-Reply-To: <419EF257.8010103@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

>> (2) NMI's don't nest. There is no possibility of NMI's racing against
>>     themselves while the data is per-cpu.
>>
> 
> Your point was that touch_nmi_watchdog() which resets alert_counter,
> is racy when resetting the counter of other CPUs. Yes it is racy.
> It is also racy against the NMI on the _current_ CPU.

Hmm no I think you're right in that it is only a problem WRT the remote
CPUs. However that would still be a problem, as the comment in i386
touch_nmi_watchdog attests.
