Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbTDFV7B (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 17:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTDFV7B (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 17:59:01 -0400
Received: from holomorphy.com ([66.224.33.161]:25244 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263130AbTDFV66 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 17:58:58 -0400
Date: Sun, 6 Apr 2003 15:10:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Robert Love <rml@tech9.net>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Martin Bligh <mbligh@aracnet.com>
Subject: Re: 2.5.65-preempt booting on 32way NUMAQ
Message-ID: <20030406221001.GQ993@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>, Robert Love <rml@tech9.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Martin Bligh <mbligh@aracnet.com>
References: <Pine.LNX.4.50.0304060625130.2268-100000@montezuma.mastecende.com> <20030406112340.GM993@holomorphy.com> <1049653846.753.156.camel@localhost> <20030406214631.GP993@holomorphy.com> <Pine.LNX.4.50.0304061749570.2268-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0304061749570.2268-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Apr 2003, William Lee Irwin III wrote:
>> I presumed the audit was perpetual and/or ongoing.

On Sun, Apr 06, 2003 at 05:50:36PM -0400, Zwane Mwaikambo wrote:
> Martin says the NUMAQ per node stuff isn't preempt safe, might be worth 
> looking there too.

The only scary bit is numa_node_id() in __alloc_pages(); this is fine
because it's speculative anyway.

There isn't much usage of numa_node_id() in the i386 arch code.


-- wli
